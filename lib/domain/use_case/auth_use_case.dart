import 'package:film_flu/domain/models/auth_entity.dart';
import 'package:film_flu/domain/repository/auth_repository.dart';

abstract class AuthUseCase {
  Future<AuthEntity> requestNewToken();
}

class AuthUseCaseImpl extends AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCaseImpl(this.authRepository);

  @override
  Future<AuthEntity> requestNewToken() async {
    return await authRepository.requestNewToken();
  }
}
