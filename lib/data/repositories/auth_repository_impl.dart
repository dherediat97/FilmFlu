import 'package:dio/dio.dart';
import 'package:film_flu/data/datasources/remote/api/network/dio_client.dart';
import 'package:film_flu/data/datasources/remote/api/network/http_exception.dart';
import 'package:film_flu/data/models/auth_remote_entity.dart';
import 'package:film_flu/domain/models/auth_entity.dart';
import 'package:film_flu/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<AuthEntity> requestNewToken() async {
    try {
      final response = await DioClient.instance.get(
        '/authentication/token/new',
      );

      AuthRemoteEntity authRemoteEntity = AuthRemoteEntity.fromJson(response);
      return authRemoteEntity.toAuthEntity();
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<AuthEntity> signOut() async {
    try {
      final response = await DioClient.instance.get('/authentication/signOut');

      AuthRemoteEntity authRemoteEntity = AuthRemoteEntity.fromJson(response);
      return authRemoteEntity.toAuthEntity();
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }
}
