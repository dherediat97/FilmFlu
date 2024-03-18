import 'package:FilmFlu/main_widget.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_detail/movie_details_page.dart';
import 'package:FilmFlu/modules/movies/widgets/person_detail/actor_details.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';
import 'package:FilmFlu/modules/shared/drivers/http/dio_client_http.dart';
import 'package:FilmFlu/modules/shared/drivers/local_storage/local_storage.dart';
import 'package:FilmFlu/modules/shared/drivers/local_storage/shared_local_storage.dart';
import 'package:FilmFlu/modules/splash/widgets/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/auth/login/login_module.dart';
import 'modules/movies/widgets/movie_list/movie_list_module.dart';
import 'modules/settings/widgets/settings_module.dart';

class AppModule extends Module {
  @override
  void binds(b) {
    b.add<ClientHttp>((i) => DioClientHttp());
    b.add<LocalStorage>((i) => SharedPrefLocalStorage());
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => SplashPage());
    r.wildcard(child: (context) => MainPage());
    r.module('/login', module: LoginModule());
    r.module('/main', module: MoviesModule());
    r.module('/settings', module: SettingsModule());
    r.child('/movieDetails', child: (context) => MovieDetailsPage());
    r.child('/personDetails/:personId',
        child: (context) =>
            PersonDetailsPage(actorId: r.args.params["personId"] as String));
  }
}
