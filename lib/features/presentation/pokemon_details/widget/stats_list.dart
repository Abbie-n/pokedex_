import 'package:flutter/material.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/presentation/pokemon_details/widget/base_stats.dart';
import 'package:pokedex/shared/extensions/string_extension.dart';
import 'package:pokedex/shared/helper.dart';

class StatsList extends StatelessWidget {
  const StatsList(this.pokemon, {super.key});
  final PokemonDetails pokemon;

  @override
  Widget build(BuildContext context) {
    if (pokemon.stats == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 150),
          child: Text('No statistics for this pokemon'),
        ),
      );
    }

    return Column(
      children: [
        Column(
          children: List.generate(
            pokemon.stats!.length,
            (index) => BaseStats(
              progress: Helper.getProgress(pokemon.stats![index].baseStat!),
              progressColor: Colors.black,
              stat: pokemon.stats![index].stat!.name!.capitalize,
              value: '${pokemon.stats![index].baseStat}',
            ),
          ),
        ),
        BaseStats(
          progress: .5,
          progressColor: Colors.black,
          stat: 'Avg. Power',
          value: Helper.getAvgPower(pokemon.stats!),
        ),
      ],
    );
  }
}
