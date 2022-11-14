import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/features/presentation/pokemon_details/cubit/save_favourite_cubit.dart';
import 'package:pokedex/features/presentation/pokemon_details/cubit/save_favourite_state.dart';
import 'package:pokedex/features/usecase/save_favourite_use_case.dart';

import '../../../../mock_data.dart';

class MockSaveFavouriteUseCase extends Mock implements SaveFavouriteUseCase {}

void main() {
  group('SaveFavouriteCubit test', () {
    late SaveFavouriteCubit saveFavouriteCubit;
    late SaveFavouriteUseCase saveFavouriteUseCase;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      saveFavouriteUseCase = MockSaveFavouriteUseCase();
      saveFavouriteCubit = SaveFavouriteCubit(saveFavouriteUseCase);
    });

    blocTest<SaveFavouriteCubit, SaveFavouriteState>(
      "Emits [SaveFavouriteState.finished] when data request is successful",
      build: () => saveFavouriteCubit,
      act: (cubit) {
        when(() => saveFavouriteUseCase(mockPokemonDetails[0])).thenAnswer(
            (value) async => Future.value(const Data.success(data: true)));

        cubit.call(mockPokemonDetails[0]);
      },
      expect: () => [
        const SaveFavouriteState.loading(),
        const SaveFavouriteState.finished()
      ],
    );

    blocTest<SaveFavouriteCubit, SaveFavouriteState>(
      "Emits [SaveFavouriteState.error] when data exception",
      build: () {
        when(() => saveFavouriteUseCase(mockPokemonDetails[0])).thenAnswer(
            (value) async => Future.value(Data.failure(Exception())));
        return saveFavouriteCubit;
      },
      act: (cubit) => cubit.call(mockPokemonDetails[0]),
      expect: () => [
        const SaveFavouriteState.loading(),
        SaveFavouriteState.error(message: Exception().toString())
      ],
    );
  });
}
