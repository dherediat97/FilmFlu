import 'package:dio/dio.dart';
import 'package:film_flu/data/datasources/remote/api/network/dio_client.dart';
import 'package:film_flu/data/datasources/remote/api/network/http_exception.dart';
import 'package:film_flu/data/models/person_remote_entity.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/domain/repository/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  @override
  Future<PersonEntity> fetchPersonData(
    String personId,
    String languageCode,
  ) async {
    try {
      final response = await DioClient.instance.get(
        '/person/$personId',
        queryParameters: {
          'language': languageCode,
          'append_to_response': 'credits',
        },
      );
      PersonRemoteEntity personData = PersonRemoteEntity.fromJson(response);
      return personData.toPersonEntity();
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }
}
