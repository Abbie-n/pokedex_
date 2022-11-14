import 'package:injectable/injectable.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/core/services/api/api_exception.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/repository/data_repository.dart';

@lazySingleton
class GetPokemonsUseCase {
  final DataRepository repository;

  GetPokemonsUseCase(this.repository);

  Future<Data<List<PokemonDetails>>> getCachedPokemons() async {
    try {
      final result = await repository.getCachedPokemons();

      if (result.isEmpty) {
        return Data.failure(NullException());
      }

      return Data.success(data: result);
    } on Exception {
      return Data.failure(GenericException());
    }
  }

  Future<Data<List<PokemonDetails>>> getPokemonsFromAPI() async {
    try {
      final result = await repository.getPokemons();

      if (result == null || result.isEmpty) {
        return Data.failure(NullException());
      }

      return Data.success(data: result);
    } on Exception {
      return Data.failure(GenericException());
    }
  }
}
