import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_favourite_state.freezed.dart';

@freezed
class SaveFavouriteState with _$SaveFavouriteState {
  const factory SaveFavouriteState.initial() = _Initial;

  const factory SaveFavouriteState.loading() = _Loading;

  const factory SaveFavouriteState.error({required String message}) = _Error;

  const factory SaveFavouriteState.finished() = _Finished;
}
