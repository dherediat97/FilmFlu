import 'package:film_flu/domain/models/auth_entity.dart';
import 'package:film_flu/domain/models/request_token_entity.dart';
import 'package:film_flu/domain/models/response_token_entity.dart';
import 'package:film_flu/domain/repository/auth_repository.dart';

abstract class AuthUseCase {
  Future<AuthEntity> requestNewToken();
  Future<bool> signOut(AuthEntity authEntity);
  Future<ResponseTokenEntity> newSession(RequestTokenEntity requestTokenEntity);
}

class AuthUseCaseImpl extends AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCaseImpl(this.authRepository);

  @override
  Future<AuthEntity> requestNewToken() async {
    return await authRepository.requestNewToken();
  }

  @override
  Future<ResponseTokenEntity> newSession(
    RequestTokenEntity requestTokenEntity,
  ) {
    return authRepository.newSession(requestTokenEntity);
  }

  @override
  Future<bool> signOut(AuthEntity authEntity) {
    return authRepository.signOut(authEntity);
  }
}
