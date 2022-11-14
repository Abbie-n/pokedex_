import 'package:injectable/injectable.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/core/services/api/api_exception.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/repository/data_repository_impl.dart';

@lazySingleton
class GetFavouritesUseCase {
  final DataRepository repository;

  GetFavouritesUseCase(this.repository);

  Future<Data<List<PokemonDetails>>> call() async {
    try {
      final result = await repository.getFavourites();

      if (result.isEmpty) {
        return Data.failure(NullException());
      }

      return Data.success(data: result);
    } on Exception {
      return Data.failure(GenericException());
    }
  }
}
