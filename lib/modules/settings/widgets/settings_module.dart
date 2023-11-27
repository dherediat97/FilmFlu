import 'package:FilmFlu/modules/auth/login/infra/datasources/auth_repository.dart';
import 'package:FilmFlu/modules/settings/widgets/settings_screen.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SettingsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind(((i) => AuthRepository(i<ClientHttp>()))),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => SettingsPage()),
      ];
}
