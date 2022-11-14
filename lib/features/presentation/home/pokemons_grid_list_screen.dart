import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/features/presentation/home/cubit/get_pokemons_cubit.dart';
import 'package:pokedex/features/presentation/home/cubit/get_pokemons_state.dart';
import 'package:pokedex/shared/extensions/connectivity_extension.dart';
import 'package:pokedex/shared/shared.dart';

class PokemonsGridViewListScreen extends HookConsumerWidget {
  const PokemonsGridViewListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getPokemonsCubitProvider);
    final scrollController = useScrollController();
    final loading = useState(false);

    scrollController.addListener(() async {
      // nextPageTrigger will have a value equivalent to 80% of the list size.
      var nextPageTrigger = 0.8 * scrollController.position.maxScrollExtent;

      // fetches new data when user scrolls to bottom of the screen
      if (scrollController.position.pixels > nextPageTrigger &&
          loading.value == false) {
        loading.value = true;
        await cubit.getPokemonsFromAPI(
            currentLength: cubit.state
                .maybeWhen(finished: (data) => data.length, orElse: () => 0),
            fetchMore: true);
        await cubit.call();
        loading.value = false;
      }
    });

    useEffect(() {
      cubit.call();
      return null;
    });

    return BlocBuilder<GetPokemonsCubit, GetPokemonsState>(
      bloc: cubit,
      builder: (context, state) => state.maybeWhen(
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 150),
            child: CircularLoadingWidget(height: 50),
          ),
        ),
        finished: (data) => RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            if (!await Connectivity().isConnected()) {
              showToast('No internet connection');

              return;
            }

            await cubit.getPokemonsFromAPI();
            await cubit.call();
          },
          child: Column(
            children: [
              Expanded(
                child: CustomGridView(
                  scrollController: scrollController,
                  children: List.generate(
                    data.length,
                    (index) {
                      return GestureDetector(
                        onTap: () => context.router
                            .push(PokemonDetailsScreen(pokemon: data[index])),
                        child: SingleItem(pokemon: data[index]),
                      );
                    },
                  ),
                ),
              ),
              if (loading.value) const CircularLoadingWidget(height: 50)
            ],
          ),
        ),
        error: (message) => Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: Text(message),
          ),
        ),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
