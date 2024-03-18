import 'package:FilmFlu/modules/movies/infra/datasources/movies_repository.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_detail/movie_details_page.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MovieDetailsModule extends Module {
  @override
  void binds(i) {
    i.add(((i) => MoviesRepository(i<ClientHttp>())));
  }

  @override
  void routes(r) {
    ChildRoute('/', child: (_) => MovieDetailsPage());
  }
}
