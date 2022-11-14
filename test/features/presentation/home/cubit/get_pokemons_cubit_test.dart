import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/model/data.dart';
import 'package:pokedex/features/presentation/home/cubit/get_pokemons_cubit.dart';
import 'package:pokedex/features/presentation/home/cubit/get_pokemons_state.dart';
import 'package:pokedex/features/usecase/get_pokemons_use_case.dart';

import '../../../../mock_data.dart';

class MockGetPokemonsUseCase extends Mock implements GetPokemonsUseCase {}

void main() {
  group('GetPokemonsCubit test', () {
    late GetPokemonsCubit getPokemonsCubit;
    late GetPokemonsUseCase getPokemonsUseCase;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      getPokemonsUseCase = MockGetPokemonsUseCase();
      getPokemonsCubit = GetPokemonsCubit(getPokemonsUseCase);
    });

    blocTest<GetPokemonsCubit, GetPokemonsState>(
      "Emits [GetPokemonsState.finished] when cache-data request is successful",
      build: () => getPokemonsCubit,
      act: (cubit) {
        when(() => getPokemonsUseCase.getCachedPokemons()).thenAnswer(
            (value) async =>
                Future.value(Data.success(data: mockPokemonDetails)));

        cubit.call();
      },
      expect: () => [
        const GetPokemonsState.loading(),
        GetPokemonsState.finished(data: mockPokemonDetails)
      ],
    );

    blocTest<GetPokemonsCubit, GetPokemonsState>(
      "Emits [GetPokemonsState.finished] when API-data request is successful",
      build: () => getPokemonsCubit,
      act: (cubit) {
        when(() => getPokemonsUseCase.getPokemonsFromAPI()).thenAnswer(
            (value) async =>
                Future.value(Data.success(data: mockPokemonDetails)));

        cubit.getPokemonsFromAPI();
      },
      expect: () => [const GetPokemonsState.loading()],
    );

    blocTest<GetPokemonsCubit, GetPokemonsState>(
      "Emits [GetPokemonsState.error] when cache-data exception",
      build: () {
        when(() => getPokemonsUseCase.getCachedPokemons()).thenAnswer(
            (value) async => Future.value(Data.failure(Exception())));
        return getPokemonsCubit;
      },
      act: (cubit) => cubit.call(),
      expect: () => [
        const GetPokemonsState.loading(),
        GetPokemonsState.error(message: Exception().toString())
      ],
    );

    blocTest<GetPokemonsCubit, GetPokemonsState>(
      "Emits [GetPokemonsState.error] when API-data exception",
      build: () {
        when(() => getPokemonsUseCase.getPokemonsFromAPI()).thenAnswer(
            (value) async => Future.value(Data.failure(Exception())));
        return getPokemonsCubit;
      },
      act: (cubit) => cubit.getPokemonsFromAPI(),
      expect: () => [const GetPokemonsState.loading()],
    );
  });
}
