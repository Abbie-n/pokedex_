import 'package:injectable/injectable.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/core/services/api/api_exception.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/repository/data_repository.dart';

@lazySingleton
class RemoveFavouriteUseCase {
  final DataRepository repository;

  RemoveFavouriteUseCase(this.repository);

  Future<Data<bool>> call(PokemonDetails pokemon) async {
    try {
      final result = await repository.removeFavourite(pokemon);

      if (!result) {
        return Data.failure(GenericException());
      }

      return Data.success(data: result);
    } on Exception {
      return Data.failure(GenericException());
    }
  }
}
