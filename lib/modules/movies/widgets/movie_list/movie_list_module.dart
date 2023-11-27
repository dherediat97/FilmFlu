import 'package:FilmFlu/modules/movies/infra/datasources/movies_repository.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_detail/movie_details_page.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';
import 'package:FilmFlu/modules/main/widgets/main_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MoviesModule extends Module {
  @override
  List<Bind> get binds => [
        Bind(((i) => MoviesRepository(i<ClientHttp>()))),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const MainPage()),
        ChildRoute('/movieDetails/:movieId',
            child: (context, args) =>
                MovieDetailsPage(movieId: args.params["movieId"] as String)),
      ];
}
