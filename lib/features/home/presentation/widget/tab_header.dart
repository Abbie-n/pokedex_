import 'package:flutter/material.dart';
import 'package:pokedex/shared/shared.dart';

class Tabheader extends StatelessWidget {
  const Tabheader({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Text('All Pokemons'),
              Row(
                children: [
                  const Text('Favourites'),
                  const XMargin(4),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const TextWidget(
                      '1',
                      textColor: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const YMargin(12),
          Align(
            alignment: Alignment.centerLeft,
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
