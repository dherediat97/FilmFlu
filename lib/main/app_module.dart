import 'package:FilmFlu/modules/auth/login/login_module.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_detail/movie_details_page.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_list/movie_list_module.dart';
import 'package:FilmFlu/modules/settings/widgets/settings_module.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';
import 'package:FilmFlu/modules/shared/drivers/http/dio_client_http.dart';
import 'package:FilmFlu/modules/shared/drivers/local_storage/local_storage.dart';
import 'package:FilmFlu/modules/shared/drivers/local_storage/shared_local_storage.dart';
import 'package:FilmFlu/modules/splash/widgets/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<ClientHttp>((i) => DioClientHttp()),
        Bind<LocalStorage>((i) => SharedPrefLocalStorage())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => SplashPage()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/main', module: MoviesModule()),
        ModuleRoute('/settings', module: SettingsModule()),
        ChildRoute('/movieDetails/:movieId',
            child: (context, args) =>
                MovieDetailsPage(movieId: args.params["movieId"] as String)),
      ];
}
