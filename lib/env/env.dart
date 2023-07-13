import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'TMDB_KEY')
  static final String tmdbApiKey = _Env.tmdbApiKey;
  @EnviedField(varName: 'IMAGE_BASE_URL')
  static final String imgBaseURL = _Env.imgBaseURL;
}
