import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/features/presentation/pokemon_details/cubit/remove_favourite_cubit.dart';
import 'package:pokedex/features/presentation/pokemon_details/cubit/remove_favourite_state.dart';
import 'package:pokedex/features/usecase/remove_favourite_use_case.dart';

import '../../../../mock_data.dart';

class MockRemoveFavouriteUseCase extends Mock
    implements RemoveFavouriteUseCase {}

void main() {
  group('RemoveFavouriteCubit test', () {
    late RemoveFavouriteCubit removeFavouriteCubit;
    late RemoveFavouriteUseCase removeFavouriteUseCase;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      removeFavouriteUseCase = MockRemoveFavouriteUseCase();
      removeFavouriteCubit = RemoveFavouriteCubit(removeFavouriteUseCase);
    });

    blocTest<RemoveFavouriteCubit, RemoveFavouriteState>(
      "Emits [RemoveFavouriteState.finished] when data request is successful",
      build: () => removeFavouriteCubit,
      act: (cubit) {
        when(() => removeFavouriteUseCase(mockPokemonDetails[0])).thenAnswer(
            (value) async => Future.value(const Data.success(data: true)));

        cubit.call(mockPokemonDetails[0]);
      },
      expect: () => [
        const RemoveFavouriteState.loading(),
        const RemoveFavouriteState.finished()
      ],
    );

    blocTest<RemoveFavouriteCubit, RemoveFavouriteState>(
      "Emits [RemoveFavouriteState.error] when data exception",
      build: () {
        when(() => removeFavouriteUseCase(mockPokemonDetails[0])).thenAnswer(
            (value) async => Future.value(Data.failure(Exception())));
        return removeFavouriteCubit;
      },
      act: (cubit) => cubit.call(mockPokemonDetails[0]),
      expect: () => [
        const RemoveFavouriteState.loading(),
        RemoveFavouriteState.error(message: Exception().toString())
      ],
    );
  });
}
