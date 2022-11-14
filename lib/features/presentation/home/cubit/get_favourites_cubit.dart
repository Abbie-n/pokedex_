import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc_provider.dart';
import 'package:pokedex/features/presentation/home/cubit/get_favourites_state.dart';
import 'package:pokedex/features/usecase/get_pokemons_use_case.dart';
import 'package:pokedex/providers.dart';

final getFavouritesCubitProvider = cubitAutoDispose<GetFavouritesCubit>(
  (ref) => GetFavouritesCubit(
    GetPokemonsUseCase(ref.read(dataRepositoryProvider)),
  ),
);

class GetFavouritesCubit extends Cubit<GetFavouritesState> {
  final GetPokemonsUseCase getPokemonsUseCase;

  GetFavouritesCubit(this.getPokemonsUseCase)
      : super(const GetFavouritesState.initial());

  Future<void> call() async {
    emit(const GetFavouritesState.loading());

    final result = await getPokemonsUseCase();

    result.maybeWhen(
      success: (data) async => emit(GetFavouritesState.finished(data: data)),
      failure: (exception) => emit(GetFavouritesState.error(
        message: exception.toString(),
      )),
      orElse: () => null,
    );
  }
}
