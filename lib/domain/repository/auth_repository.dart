import 'package:film_flu/data/repositories/auth_repository_impl.dart';
import 'package:film_flu/domain/models/auth_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(ref) => AuthRepositoryImpl();

abstract interface class AuthRepository {
  Future<AuthEntity> requestNewToken();
  Future<AuthEntity> signOut();
}
