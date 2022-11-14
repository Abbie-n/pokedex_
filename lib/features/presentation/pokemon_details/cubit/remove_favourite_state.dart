import 'package:freezed_annotation/freezed_annotation.dart';

part 'remove_favourite_state.freezed.dart';

@freezed
class RemoveFavouriteState with _$RemoveFavouriteState {
  const factory RemoveFavouriteState.initial() = _Initial;

  const factory RemoveFavouriteState.loading() = _Loading;

  const factory RemoveFavouriteState.error({required String message}) = _Error;

  const factory RemoveFavouriteState.finished() = _Finished;
}
