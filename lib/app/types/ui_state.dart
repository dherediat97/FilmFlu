import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state.freezed.dart';

@freezed
class UiState with _$UiState {
  const factory UiState.initial() = _Initial;
  const factory UiState.success() = _Success;
  const factory UiState.error([String? error]) = _Error;
  const factory UiState.loading() = _Loading;
}

extension UiStateExtension on UiState {
  bool isLoading() => maybeWhen(orElse: () => false, loading: () => true);

  bool isError() => maybeWhen(orElse: () => false, error: (_) => true);

  bool isSuccess() => maybeWhen(orElse: () => false, success: () => true);
}
