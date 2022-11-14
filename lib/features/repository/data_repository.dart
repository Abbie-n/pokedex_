import 'package:pokedex/features/model/pokemon_details_model.dart';

abstract class DataRepository {
  Future<bool> saveFavourite(PokemonDetails pokemon);
  Future<List<PokemonDetails>> getFavourites();
  Future getPokemons();
  Future<List<PokemonDetails>> getCachedPokemons();
  Future<bool> removeFavourite(PokemonDetails pokemon);
  Future<bool> isFavourite(PokemonDetails pokemon);
}
