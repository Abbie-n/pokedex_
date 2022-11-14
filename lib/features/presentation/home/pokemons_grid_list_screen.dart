import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/shared/shared.dart';

class PokemonsGridViewListScreen extends StatelessWidget {
  const PokemonsGridViewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGridView(
      children: List.generate(
        9,
        (index) => GestureDetector(
          onTap: () => context.router.push(const PokemonDetailsScreen()),
          child: const SingleItem(),
        ),
      ),
    );
  }
}
