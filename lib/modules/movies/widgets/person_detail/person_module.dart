import 'package:FilmFlu/modules/movies/infra/datasources/movies_repository.dart';
import 'package:FilmFlu/modules/movies/widgets/person_detail/actor_details.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MoviesModule extends Module {
  @override
  List<Bind> get binds => [
        Bind(((i) => MoviesRepository(i<ClientHttp>()))),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/personDetails/:personId',
            child: (context, args) =>
                PersonDetailsPage(actorId: args.params["actorId"] as String)),
      ];
}
