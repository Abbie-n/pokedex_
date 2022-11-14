import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc_provider.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/presentation/pokemon_details/cubit/save_favourite_state.dart';
import 'package:pokedex/features/usecase/save_favourite_use_case.dart';
import 'package:pokedex/providers.dart';

final aveFavouriteCubitProvider = cubitAutoDispose<SaveFavouriteCubit>(
  (ref) => SaveFavouriteCubit(
    SaveFavouriteUseCase(ref.read(dataRepositoryProvider)),
  ),
);

class SaveFavouriteCubit extends Cubit<SaveFavouriteState> {
  final SaveFavouriteUseCase saveFavouriteUseCase;

  SaveFavouriteCubit(this.saveFavouriteUseCase)
      : super(const SaveFavouriteState.initial());

  Future<void> call(PokemonDetails pokemon) async {
    emit(const SaveFavouriteState.loading());

    final result = await saveFavouriteUseCase(pokemon);

    result.maybeWhen(
      success: (data) async => emit(const SaveFavouriteState.finished()),
      failure: (exception) => emit(SaveFavouriteState.error(
        message: exception.toString(),
      )),
      orElse: () => null,
    );
  }
}
