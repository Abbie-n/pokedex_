import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/features/repository/data_repository.dart';
import 'package:pokedex/features/usecase/save_favourite_use_case.dart';
import '../../mock_data.dart';
import '../../mock_repository.dart';

void main() {
  group('SaveFavouriteUseCase test', () {
    late DataRepository repository;
    late SaveFavouriteUseCase saveFavouriteUseCase;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      repository = MockDataRepository();
      saveFavouriteUseCase = SaveFavouriteUseCase(repository);
    });

    test("Should save favourite", () async {
      when(() => repository.saveFavourite(mockPokemonDetails[0]))
          .thenAnswer((invocation) => Future.value(true));

      // act
      final result = await saveFavouriteUseCase(mockPokemonDetails[0]);

      // assert
      expect(result, isA<Data>());

      result.maybeWhen(
        success: (data) => expect(data, equals(true)),
        orElse: () => null,
      );
    });
  });
}
