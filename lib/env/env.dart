import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env', useConstantCase: true, obfuscate: false)
final class Env {
  @EnviedField()
  static String tmdbApiKey = _Env.tmdbApiKey;

  @EnviedField()
  static String firebaseApiKeyWeb = _Env.firebaseApiKeyWeb;

  @EnviedField()
  static String firebaseApiKeyAndroid = _Env.firebaseApiKeyWeb;

  @EnviedField()
  static String firebaseApiKeyApple = _Env.firebaseApiKeyApple;

  @EnviedField()
  static String firebaseMessagingSenderId = _Env.firebaseMessagingSenderId;

  @EnviedField()
  static String firebaseAppIdWeb = _Env.firebaseAppIdWeb;

  @EnviedField()
  static String firebaseAppIdAndroid = _Env.firebaseAppIdAndroid;

  @EnviedField()
  static String firebaseAppIdApple = _Env.firebaseAppIdApple;

  @EnviedField()
  static String firebaseProjectName = _Env.firebaseProjectName;

  @EnviedField()
  static String firebaseClientIdApple = _Env.firebaseClientIdApple;

  @EnviedField()
  static String firebaseMeasurementId = _Env.firebaseMeasurementId;

  @EnviedField()
  static String googleClientId = _Env.googleClientId;
}
