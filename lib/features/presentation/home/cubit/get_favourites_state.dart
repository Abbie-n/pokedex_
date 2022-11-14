import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';

part 'get_favourites_state.freezed.dart';

@freezed
class GetFavouritesState with _$GetFavouritesState {
  const factory GetFavouritesState.initial() = _Initial;

  const factory GetFavouritesState.loading() = _Loading;

  const factory GetFavouritesState.error({required String message}) = _Error;

  const factory GetFavouritesState.finished(
      {required List<PokemonDetails> data}) = _Finished;
}
