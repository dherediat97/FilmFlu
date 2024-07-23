part of 'splash_bloc.dart';

@freezed
class SplashEvent with _$SplashEvent {
  const factory SplashEvent.unSplashInNMilliseconds(int milliseconds) =
      _UnSplashInNMilliseconds;
}
