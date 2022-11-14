import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/features/repository/data_repository.dart';
import 'package:pokedex/features/usecase/get_favourites_use_case.dart';
import '../../mock_data.dart';
import '../../mock_repository.dart';

void main() {
  group('GetFavouritesUseCase test', () {
    late DataRepository repository;
    late GetFavouritesUseCase getFavouritesUseCase;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      repository = MockDataRepository();
      getFavouritesUseCase = GetFavouritesUseCase(repository);
    });

    test("Should get favourites", () async {
      when(() => repository.getFavourites())
          .thenAnswer((invocation) => Future.value(mockPokemonDetails));

      // act
      final result = await getFavouritesUseCase.call();

      // assert
      expect(result, isA<Data>());

      result.maybeWhen(
        success: (data) => expect(data, equals(mockPokemonDetails)),
        orElse: () => null,
      );
    });
  });
}
