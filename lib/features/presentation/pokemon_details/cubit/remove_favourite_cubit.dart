import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc_provider.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/presentation/pokemon_details/cubit/remove_favourite_state.dart';
import 'package:pokedex/features/usecase/remove_favourite_use_case.dart';
import 'package:pokedex/providers.dart';

final removeFavouriteCubitProvider = cubitAutoDispose<RemoveFavouriteCubit>(
  (ref) => RemoveFavouriteCubit(
    RemoveFavouriteUseCase(ref.read(dataRepositoryProvider)),
  ),
);

class RemoveFavouriteCubit extends Cubit<RemoveFavouriteState> {
  final RemoveFavouriteUseCase removeFavouriteUseCase;

  RemoveFavouriteCubit(this.removeFavouriteUseCase)
      : super(const RemoveFavouriteState.initial());

  Future<void> call(PokemonDetails pokemon) async {
    emit(const RemoveFavouriteState.loading());

    final result = await removeFavouriteUseCase(pokemon);

    result.maybeWhen(
      success: (data) async => emit(const RemoveFavouriteState.finished()),
      failure: (exception) => emit(RemoveFavouriteState.error(
        message: exception.toString(),
      )),
      orElse: () => null,
    );
  }
}
