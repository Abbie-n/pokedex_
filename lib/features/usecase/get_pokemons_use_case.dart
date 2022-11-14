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

  Future<Data<List<PokemonDetails>>> getPokemonsFromAPI(
      {int currentLength = 12, bool fetchMore = false}) async {
    try {
      final result = await repository.getPokemons(
          currentLength: currentLength, fetchMore: fetchMore);

      if (result == null || result.isEmpty) {
        return Data.failure(NullException());
      }

      return Data.success(data: result);
    } on Exception {
      return Data.failure(GenericException());
    }
  }
}
