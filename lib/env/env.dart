import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'TMDB_KEY')
  static const String tmdbApiKey = _Env.tmdbApiKey;

  @EnviedField(varName: 'FIREBASE_API_KEY_WEB')
  static const String firebaseApiKeyWeb = _Env.firebaseApiKeyWeb;

  @EnviedField(varName: 'FIREBASE_API_KEY_ANDROID')
  static const String firebaseApiKeyAndroid = _Env.firebaseApiKeyAndroid;

  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID')
  static const String firebaseMessagingSenderId =
      _Env.firebaseMessagingSenderId;

  @EnviedField(varName: 'FIREBASE_APP_ID_WEB')
  static const String firebaseAppIdWeb = _Env.firebaseAppIdWeb;

  @EnviedField(varName: 'FIREBASE_APP_ID_ANDROID')
  static const String firebaseAppIdAndroid = _Env.firebaseAppIdAndroid;

  @EnviedField(varName: 'FIREBASE_PROJECT_NAME')
  static const String firebaseProjectName = _Env.firebaseProjectName;

  @EnviedField(varName: 'FIREBASE_MEASUREMENT_ID_WEB')
  static const String firebaseMeasurementIdWeb = _Env.firebaseMeasurementIdWeb;
}
