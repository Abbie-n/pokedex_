import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc_provider.dart';
import 'package:pokedex/features/presentation/home/cubit/get_pokemons_state.dart';
import 'package:pokedex/features/usecase/get_pokemons_use_case.dart';
import 'package:pokedex/providers.dart';

final getPokemonsCubitProvider = cubitAutoDispose<GetPokemonsCubit>(
  (ref) => GetPokemonsCubit(
    GetPokemonsUseCase(ref.read(dataRepositoryProvider)),
  ),
);

class GetPokemonsCubit extends Cubit<GetPokemonsState> {
  final GetPokemonsUseCase getPokemonsUseCase;

  GetPokemonsCubit(this.getPokemonsUseCase)
      : super(const GetPokemonsState.initial());

  Future<void> call() async {
    emit(const GetPokemonsState.loading());

    final result = await getPokemonsUseCase.getCachedPokemons();

    result.maybeWhen(
      success: (data) async => emit(GetPokemonsState.finished(data: data)),
      failure: (exception) => emit(GetPokemonsState.error(
        message: exception.toString(),
      )),
      orElse: () => null,
    );
  }

  Future<void> getPokemonsFromAPI() async {
    emit(const GetPokemonsState.loading());

    await getPokemonsUseCase.getPokemonsFromAPI();
  }
}
