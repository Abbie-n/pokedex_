import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pokedex/features/presentation/home/favourites_tab.dart';
import 'package:pokedex/features/presentation/home/pokemons_grid_list_screen.dart';
import 'package:pokedex/features/presentation/home/widget/tab_header.dart';
import 'package:pokedex/shared/shared.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 60, bottom: 13),
            decoration: const BoxDecoration(color: Colors.white),
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              Constants.textLogo,
              scale: 4,
            ),
          ),
          const YMargin(2),
          Tabheader(selectedTab: (value) => selectedTab.value = value),
          if (selectedTab.value == 0)
            const Expanded(child: PokemonsGridViewListScreen())
          else
            const Expanded(child: FavouritesListScreen()),
        ],
      ),
    );
  }
}
