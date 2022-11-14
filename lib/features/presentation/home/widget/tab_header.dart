import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/features/presentation/home/cubit/get_favourites_cubit.dart';
import 'package:pokedex/features/presentation/home/cubit/get_favourites_state.dart';
import 'package:pokedex/shared/shared.dart';

class Tabheader extends HookConsumerWidget {
  const Tabheader({super.key, required this.selectedTab});
  final ValueChanged<int> selectedTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getFavouritesCubitProvider);
    final selectedIndex = useState(0);

    useEffect(() {
      cubit.call();
      return null;
    });

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(color: Colors.white),
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  selectedIndex.value = 0;
                  selectedTab.call(selectedIndex.value);
                },
                child: const Text('All Pokemons'),
              ),
              GestureDetector(
                onTap: () {
                  selectedIndex.value = 1;
                  selectedTab.call(selectedIndex.value);
                },
                child: Row(
                  children: [
                    const Text('Favourites'),
                    const XMargin(4),
                    BlocBuilder<GetFavouritesCubit, GetFavouritesState>(
                      bloc: cubit,
                      builder: (context, state) => state.maybeWhen(
                        finished: (data) => Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: TextWidget(
                            '${data.length}',
                            textColor: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const YMargin(12),
          Align(
            alignment: selectedIndex.value == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: 187.5,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
