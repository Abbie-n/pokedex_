import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';

part 'get_pokemons_state.freezed.dart';

@freezed
class GetPokemonsState with _$GetPokemonsState {
  const factory GetPokemonsState.initial() = _Initial;

  const factory GetPokemonsState.loading() = _Loading;

  const factory GetPokemonsState.error({required String message}) = _Error;

  const factory GetPokemonsState.finished(
      {required List<PokemonDetails> data}) = _Finished;
}
