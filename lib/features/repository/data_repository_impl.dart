import 'package:pokedex/features/model/pokemon_details_model.dart';

abstract class DataRepository {
  Future<bool> saveFavourites(PokemonDetails pokemon);
  Future<List<PokemonDetails>> getFavourites();
  Future<List<PokemonDetails>> getPokemons();
  Future<bool> removeFavourite(PokemonDetails pokemon);
}
