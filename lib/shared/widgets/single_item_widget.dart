import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/shared/helper.dart';
import 'package:pokedex/shared/extensions/string_extension.dart';
import 'package:pokedex/shared/extensions/int_extension.dart';
import 'package:pokedex/shared/shared.dart';

class SingleItem extends StatelessWidget {
  const SingleItem({super.key, required this.pokemon});
  final PokemonDetails pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(color: Colors.white),
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: CircularLoadingWidget(height: 50),
            ),
            errorWidget: (context, url, _) => const SizedBox.shrink(),
            imageUrl:
                pokemon.sprites?.other?.officialArtwork?.frontDefault ?? '',
            imageBuilder: (context, imageProvider) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              decoration: BoxDecoration(
                color: Helper.getContainerColor(
                    Helper.concatenateString(pokemon.types!)),
              ),
              child: Image.network(
                pokemon.sprites!.other!.officialArtwork!.frontDefault!,
                scale: 4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YMargin(8),
                TextWidget(
                  '${pokemon.id?.serialize}',
                  textColor: AppColors.grey,
                  fontSize: 12,
                ),
                const YMargin(2),
                TextWidget(
                  pokemon.name?.capitalize,
                  textColor: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                const YMargin(10),
                if (pokemon.types != null && pokemon.types!.isNotEmpty)
                  TextWidget(
                    Helper.concatenateString(pokemon.types!),
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
