import 'package:flutter/material.dart';
import 'package:pokedex/features/home/presentation/widget/tab_header.dart';
import 'package:pokedex/shared/shared.dart';
import 'package:pokedex/shared/widgets/custom_gridview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Tabheader(),
          Expanded(
            child: CustomGridView(
              children: List.generate(
                9,
                (index) => const SingleItem(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
