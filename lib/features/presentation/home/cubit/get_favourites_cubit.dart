import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc_provider.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/presentation/home/cubit/get_favourites_state.dart';
import 'package:pokedex/features/usecase/get_favourites_use_case.dart';
import 'package:pokedex/providers.dart';

final getFavouritesCubitProvider = cubitAutoDispose<GetFavouritesCubit>(
  (ref) => GetFavouritesCubit(
    GetFavouritesUseCase(ref.read(dataRepositoryProvider)),
  ),
);

class GetFavouritesCubit extends Cubit<GetFavouritesState> {
  final GetFavouritesUseCase getFavouritesUseCase;

  GetFavouritesCubit(this.getFavouritesUseCase)
      : super(const GetFavouritesState.initial());

  Future<void> call() async {
    emit(const GetFavouritesState.loading());

    final result = await getFavouritesUseCase();

    result.maybeWhen(
      success: (data) async => emit(GetFavouritesState.finished(data: data)),
      failure: (exception) => emit(GetFavouritesState.error(
        message: exception.toString(),
      )),
      orElse: () => null,
    );
  }

  Future<bool> isFavourite(PokemonDetails pokemon) async {
    final result = await getFavouritesUseCase.isFavourite(pokemon);

    return result.maybeWhen(
      success: (data) => data,
      failure: (exception) => false,
      orElse: () => false,
    );
  }
}
