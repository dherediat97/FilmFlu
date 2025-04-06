import 'package:dio/dio.dart';
import 'package:film_flu/data/datasources/remote/api/network/dio_client.dart';
import 'package:film_flu/data/datasources/remote/api/network/http_exception.dart';
import 'package:film_flu/data/models/auth_remote_entity.dart';
import 'package:film_flu/domain/models/auth_entity.dart';
import 'package:film_flu/domain/models/profile_entity.dart';
import 'package:film_flu/domain/models/request_token_entity.dart';
import 'package:film_flu/domain/models/response_token_entity.dart';
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
  Future<bool> signOut(AuthEntity authEntity) async {
    try {
      await DioClient.instance.get(
        '/authentication/session/',
        httpMethod: HttpMethod.deleteRequest,
        data: {'session_id': authEntity},
      );

      return true;
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<ResponseTokenEntity> newSession(
    RequestTokenEntity requestTokenEntity,
  ) async {
    try {
      final response = await DioClient.instance.get(
        '/authentication/session/new',
        httpMethod: HttpMethod.postRequest,
        data: {
          'approved': requestTokenEntity.approved,
          'request_token': requestTokenEntity.requestToken,
        },
      );

      final responseTokenEntity = ResponseTokenEntity.fromJson(response);
      return responseTokenEntity;
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<ProfileEntity> getProfile(String accountId) async {
    try {
      final response = await DioClient.instance.get(
        '/account/$accountId',
        httpMethod: HttpMethod.getRequest,
      );

      final responseProfile = ProfileEntity.fromJson(response);
      return responseProfile;
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<ProfileEntity> addFavorite(String accountId) {
    throw UnimplementedError();
  }
}
