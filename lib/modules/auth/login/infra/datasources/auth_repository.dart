import 'package:FilmFlu/modules/errors/errors.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_http.dart';

class AuthRepository {
  final ClientHttp _client;

  AuthRepository(this._client);

  login() async {
    try {} catch (e) {
      throw AuthException(
          message: "No se ha encontrado usuario con esas credenciales");
    }
  }
}
