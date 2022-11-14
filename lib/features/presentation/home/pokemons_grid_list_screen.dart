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
            cubit.call();
          },
          child: CustomGridView(
            children: List.generate(
              data.length,
              (index) => GestureDetector(
                onTap: () => context.router
                    .push(PokemonDetailsScreen(pokemon: data[index])),
                child: SingleItem(pokemon: data[index]),
              ),
            ),
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
