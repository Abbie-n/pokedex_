import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/features/presentation/home/cubit/get_favourites_cubit.dart';
import 'package:pokedex/features/presentation/home/cubit/get_favourites_state.dart';
import 'package:pokedex/shared/shared.dart';

class FavouritesListScreen extends HookConsumerWidget {
  const FavouritesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getFavouritesCubitProvider);

    useEffect(() {
      cubit.call();
      return null;
    }, []);

    return BlocBuilder<GetFavouritesCubit, GetFavouritesState>(
      bloc: cubit,
      builder: (context, state) => state.maybeWhen(
        loading: () => const CircularLoadingWidget(height: 50),
        finished: (data) => CustomGridView(
          children: List.generate(
            data.length,
            (index) => GestureDetector(
              onTap: () => context.router.push(
                PokemonDetailsScreen(pokemon: data[index]),
              ),
              child: SingleItem(pokemon: data[index]),
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
