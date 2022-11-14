import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/features/repository/data_repository.dart';
import 'package:pokedex/features/usecase/remove_favourite_use_case.dart';
import '../../mock_data.dart';
import '../../mock_repository.dart';

void main() {
  group('RemoveFavouriteUseCase test', () {
    late DataRepository repository;
    late RemoveFavouriteUseCase removeFavouriteUseCase;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      repository = MockDataRepository();
      removeFavouriteUseCase = RemoveFavouriteUseCase(repository);
    });

    test("Should remove favourite", () async {
      when(() => repository.removeFavourite(mockPokemonDetails[0]))
          .thenAnswer((invocation) => Future.value(true));

      // act
      final result = await removeFavouriteUseCase(mockPokemonDetails[0]);

      // assert
      expect(result, isA<Data>());

      result.maybeWhen(
        success: (data) => expect(data, equals(true)),
        orElse: () => null,
      );
    });
  });
}
