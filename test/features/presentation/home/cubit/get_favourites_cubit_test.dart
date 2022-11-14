import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/features/presentation/home/cubit/get_favourites_cubit.dart';
import 'package:pokedex/features/presentation/home/cubit/get_favourites_state.dart';
import 'package:pokedex/features/usecase/get_favourites_use_case.dart';

import '../../../../mock_data.dart';

class MockGetFavouritesUseCase extends Mock implements GetFavouritesUseCase {}

void main() {
  group('GetFavouritesCubit test', () {
    late GetFavouritesCubit getFavouritesCubit;
    late GetFavouritesUseCase getFavouritesUseCase;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      getFavouritesUseCase = MockGetFavouritesUseCase();
      getFavouritesCubit = GetFavouritesCubit(getFavouritesUseCase);
    });

    blocTest<GetFavouritesCubit, GetFavouritesState>(
      "Emits [GetFavouritesState.finished] when data request is successful",
      build: () => getFavouritesCubit,
      act: (cubit) {
        when(() => getFavouritesUseCase()).thenAnswer((value) async =>
            Future.value(Data.success(data: mockPokemonDetails)));

        cubit.call();
      },
      expect: () => [
        const GetFavouritesState.loading(),
        GetFavouritesState.finished(data: mockPokemonDetails)
      ],
    );

    blocTest<GetFavouritesCubit, GetFavouritesState>(
      "Emits [GetFavouritesState.error] when data exception",
      build: () {
        when(() => getFavouritesUseCase()).thenAnswer(
            (value) async => Future.value(Data.failure(Exception())));
        return getFavouritesCubit;
      },
      act: (cubit) => cubit.call(),
      expect: () => [
        const GetFavouritesState.loading(),
        GetFavouritesState.error(message: Exception().toString())
      ],
    );
  });
}
