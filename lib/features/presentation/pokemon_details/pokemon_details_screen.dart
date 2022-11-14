import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/presentation/home/cubit/get_favourites_cubit.dart';
import 'package:pokedex/features/presentation/pokemon_details/cubit/remove_favourite_cubit.dart';
import 'package:pokedex/features/presentation/pokemon_details/cubit/save_favourite_cubit.dart';
import 'package:pokedex/features/presentation/pokemon_details/widget/stats_list.dart';
import 'package:pokedex/shared/helper.dart';
import 'package:pokedex/shared/shared.dart';
import 'package:pokedex/shared/extensions/string_extension.dart';
import 'package:pokedex/shared/extensions/int_extension.dart';

import 'widget/vitals_widget.dart';

class PokemonDetailsScreen extends HookConsumerWidget {
  const PokemonDetailsScreen({
    super.key,
    required this.pokemon,
    this.isFave = false,
  });

  final PokemonDetails pokemon;
  final bool isFave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveFavouriteCubit = ref.watch(saveFavouriteCubitProvider);
    final removeFavouriteCubit = ref.watch(removeFavouriteCubitProvider);
    final getFavouritesCubit = ref.watch(getFavouritesCubitProvider);

    final isFave = useState(this.isFave);

    void favouriteCheck() async {
      isFave.value = await getFavouritesCubit.isFavourite(pokemon);
    }

    useEffect(() {
      favouriteCheck();
      return null;
    }, []);

    return BaseWidget(
      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () async {
            if (isFave.value) {
              await removeFavouriteCubit.call(pokemon);
              removeFavouriteCubit.state.maybeWhen(
                finished: () => isFave.value = false,
                orElse: () => null,
              );
              return;
            }
            await saveFavouriteCubit.call(pokemon);
            saveFavouriteCubit.state.maybeWhen(
              finished: () => isFave.value = true,
              orElse: () => null,
            );
          },
          backgroundColor:
              isFave.value ? AppColors.lightPurple : AppColors.primaryColor,
          label: TextWidget(
            !isFave.value ? 'Mark as favourite' : 'Remove from favourites',
            textColor: isFave.value ? AppColors.primaryColor : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar.medium(
            pinned: true,
            floating: true,
            snap: true,
            elevation: 0,
            expandedHeight: 320,
            backgroundColor: Helper.getContainerColor(
                Helper.concatenateString(pokemon.types!)),
            leading: GestureDetector(
              onTap: () async {
                await getFavouritesCubit.call();
                context.router.pop();
              },
              child: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 30,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 300,
                      padding: const EdgeInsets.fromLTRB(0, 100, 0, 14),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: AppColors.scaffoldBg,
                              thickness: 2,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        pokemon.name?.capitalize,
                                        textColor: Colors.black,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      TextWidget(
                                        Helper.concatenateString(
                                            pokemon.types!),
                                        textColor: AppColors.darkText,
                                      ),
                                      const Spacer(),
                                      if (pokemon.types != null &&
                                          pokemon.types!.isNotEmpty)
                                        TextWidget(
                                          '${pokemon.id?.serialize}',
                                          textColor: AppColors.darkText,
                                        ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          const Center(
                                        child:
                                            CircularLoadingWidget(height: 50),
                                      ),
                                      errorWidget: (context, url, _) =>
                                          const SizedBox.shrink(),
                                      imageUrl: pokemon.sprites?.other
                                              ?.officialArtwork?.frontDefault ??
                                          '',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: 125,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: Image.network(
                                          pokemon.sprites!.other!
                                              .officialArtwork!.frontDefault!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(color: Colors.white),
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VitalsWidget(
                            value: '${pokemon.height}',
                            vitalsName: 'Height',
                          ),
                          VitalsWidget(
                            value: '${pokemon.weight}',
                            vitalsName: 'Weight',
                          ),
                          VitalsWidget(
                            value:
                                Helper.getBMI(pokemon.weight!, pokemon.height!),
                            vitalsName: 'BMI',
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      'Base stats',
                      textColor: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    const YMargin(12),
                    const Divider(
                      color: AppColors.scaffoldBg,
                      height: 1,
                    ),
                    const YMargin(16),
                    StatsList(pokemon)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
