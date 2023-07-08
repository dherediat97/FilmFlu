import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'TMDB_KEY')
  static const String tmdbApiKey = _Env.tmdbApiKey;
  @EnviedField(varName: 'IMAGE_BASE_URL')
  static const String imgBaseURL =
      "https://www.themoviedb.org/t/p/w300_and_h450_bestv2";
}
