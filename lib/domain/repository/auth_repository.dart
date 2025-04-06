import 'package:film_flu/data/repositories/auth_repository_impl.dart';
import 'package:film_flu/domain/models/auth_entity.dart';
import 'package:film_flu/domain/models/profile_entity.dart';
import 'package:film_flu/domain/models/request_token_entity.dart';
import 'package:film_flu/domain/models/response_token_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(ref) => AuthRepositoryImpl();

abstract interface class AuthRepository {
  Future<AuthEntity> requestNewToken();
  Future<ProfileEntity> getProfile(String accountId);
  Future<bool> signOut(AuthEntity authEntity);
  Future<ResponseTokenEntity> newSession(RequestTokenEntity requestTokenEntity);
}
