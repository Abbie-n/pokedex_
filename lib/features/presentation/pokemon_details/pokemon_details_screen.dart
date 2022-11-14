import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/presentation/pokemon_details/widget/stats_list.dart';
import 'package:pokedex/shared/shared.dart';

import 'widget/vitals_widget.dart';

class PokemonDetailsScreen extends StatelessWidget {
  const PokemonDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: AppColors.primaryColor,
          label: const TextWidget(
            'Mark as favourite',
            textColor: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            elevation: 0,
            expandedHeight: 320,
            backgroundColor: AppColors.grass,
            leading: GestureDetector(
              onTap: () => context.router.pop(),
              child: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 30,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 300,
                        padding: const EdgeInsets.fromLTRB(0, 100, 0, 14),
                        decoration: const BoxDecoration(color: AppColors.grass),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: AppColors.scaffoldBg,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        TextWidget(
                                          'Bulbasaur',
                                          textColor: Colors.black,
                                          fontSize: 32,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        TextWidget(
                                          'Grass, Poison',
                                          textColor: AppColors.darkText,
                                        ),
                                        Spacer(),
                                        TextWidget(
                                          '#001',
                                          textColor: AppColors.darkText,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Image.asset(
                                        Constants.textLogo,
                                        scale: 4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 78,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(color: Colors.white),
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            VitalsWidget(
                              value: '69',
                              vitalsName: 'Height',
                            ),
                            VitalsWidget(
                              value: '7',
                              vitalsName: 'Weight',
                            ),
                            VitalsWidget(
                              value: '14.7',
                              vitalsName: 'BMI',
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //3
          SliverFillRemaining(
            child: Column(
              children: [
                const YMargin(8),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        TextWidget(
                          'Base stats',
                          textColor: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        YMargin(12),
                        Divider(
                          color: AppColors.scaffoldBg,
                          height: 1,
                        ),
                        YMargin(16),
                        StatsList()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
