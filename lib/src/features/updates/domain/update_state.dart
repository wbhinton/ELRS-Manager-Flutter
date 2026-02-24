import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_state.freezed.dart';

@freezed
abstract class UpdateState with _$UpdateState {
  const factory UpdateState({
    @Default(false) bool isUpdateAvailable,
    @Default('') String latestVersion,
    @Default('') String releaseUrl,
    @Default(false) bool isChecking,
    @Default(false) bool dismissed,
  }) = _UpdateState;
}
