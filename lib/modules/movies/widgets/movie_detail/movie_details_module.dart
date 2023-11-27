import 'package:FilmFlu/modules/movies/infra/datasources/movies_repository.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_detail/movie_details_page.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MovieDetailsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind(((i) => MoviesRepository(i<ClientHttp>()))),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/:movieId',
            child: (context, args) => MovieDetailsPage(
                movieId: args.queryParams["movieId"] as String)),
      ];
}
