import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_event.freezed.dart';

@freezed
class SplashEvent with _$SplashEvent {
  const factory SplashEvent.unSplashInNMilliseconds(int milliseconds) =
      _UnSplashInNMilliseconds;
}
