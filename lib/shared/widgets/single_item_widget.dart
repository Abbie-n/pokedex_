import 'package:flutter/material.dart';
import 'package:pokedex/shared/shared.dart';

class SingleItem extends StatelessWidget {
  const SingleItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 186,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(color: Colors.white),
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 104,
            padding: const EdgeInsets.symmetric(horizontal: 9),
            decoration: const BoxDecoration(
              color: AppColors.grass,
            ),
            child: Image.asset(
              Constants.textLogo,
              scale: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                YMargin(8),
                TextWidget(
                  '#001',
                  textColor: AppColors.grey,
                  fontSize: 12,
                ),
                YMargin(2),
                TextWidget(
                  'Bulbasaur',
                  textColor: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                YMargin(10),
                TextWidget(
                  'Grass, Poison',
                  textColor: AppColors.grey,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
