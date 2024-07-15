import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;
  const factory SplashState.splashed() = _Splashed;
}

extension SplashStateExtension on SplashState {
  bool isSplashed() => when(initial: () => false, splashed: () => true);
}
