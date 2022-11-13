import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemons/single_view/presentation/widget/base_stats.dart';

class StatsList extends StatelessWidget {
  const StatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        BaseStats(
          progress: .5,
          progressColor: Colors.black,
          stat: 'Hp',
          value: '30',
        ),
        BaseStats(
          progress: .5,
          progressColor: Colors.black,
          stat: 'Attack',
          value: '30',
        ),
        BaseStats(
          progress: .5,
          progressColor: Colors.black,
          stat: 'Defense',
          value: '30',
        ),
        BaseStats(
          progress: .5,
          progressColor: Colors.black,
          stat: 'Special Attack',
          value: '30',
        ),
        BaseStats(
          progress: .5,
          progressColor: Colors.black,
          stat: 'Special Defense',
          value: '30',
        ),
        BaseStats(
          progress: .5,
          progressColor: Colors.black,
          stat: 'Speed',
          value: '30',
        ),
        BaseStats(
          progress: .5,
          progressColor: Colors.black,
          stat: 'Avg. Power',
          value: '30',
        ),
      ],
    );
  }
}
