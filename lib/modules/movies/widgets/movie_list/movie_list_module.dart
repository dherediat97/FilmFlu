import 'package:FilmFlu/modules/movies/infra/datasources/movies_repository.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_detail/movie_details_page.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';
import 'package:FilmFlu/main_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MoviesModule extends Module {
  @override
  void binds(i) {
    i.add(((i) => MoviesRepository(i<ClientHttp>())));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const MainPage());
    r.child('/movieDetails/:movieId',
        child: (context) =>
            MovieDetailsPage(movieId: r.args.params["movieId"] as String));
  }
}
