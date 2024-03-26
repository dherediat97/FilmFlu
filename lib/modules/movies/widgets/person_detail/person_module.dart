import 'package:FilmFlu/modules/movies/infra/datasources/movies_repository.dart';
import 'package:FilmFlu/modules/movies/widgets/person_detail/actor_details.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MoviesModule extends Module {
  @override
  void binds(i) {
    i.add(((i) => HttpMoviesRepository(client: i<ClientHttp>())));
  }

  @override
  void routes(r) {
    ChildRoute('/personDetails/:personId',
        child: (context) =>
            PersonDetailsPage(actorId: r.args.params["actorId"] as String));
  }
}
