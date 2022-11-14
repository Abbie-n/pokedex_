import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/features/repository/data_repository.dart';
import 'package:pokedex/features/usecase/get_pokemons_use_case.dart';
import '../../mock_data.dart';
import '../../mock_repository.dart';

void main() {
  group('GetPokemonsUseCase test', () {
    late DataRepository repository;
    late GetPokemonsUseCase getPokemonsUseCase;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      repository = MockDataRepository();
      getPokemonsUseCase = GetPokemonsUseCase(repository);
    });

    test("Should get pokemons", () async {
      when(() => repository.getPokemons())
          .thenAnswer((invocation) => Future.value(mockPokemonDetails));

      // act
      final result = await getPokemonsUseCase.getPokemonsFromAPI();

      // assert
      expect(result, isA<Data>());

      result.maybeWhen(
        success: (data) => expect(data, equals(mockPokemonDetails)),
        orElse: () => null,
      );
    });
  });
}
