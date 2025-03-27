import 'package:dio/dio.dart';
import 'package:film_flu/data/datasources/remote/api/network/dio_client.dart';
import 'package:film_flu/data/datasources/remote/api/network/http_exception.dart';
import 'package:film_flu/data/models/person_remote_entity.dart';
import 'package:film_flu/domain/enums/time_windows.dart';
import 'package:film_flu/domain/models/data_person_list.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/domain/repository/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  @override
  Future<PersonEntity> fetchPersonData(
    int personId,
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

  @override
  Future<(int page, List<PersonEntity> items)> getTrendingPersons(
    TimeWindow timeWindow,
    String languageId,
    int page,
  ) async {
    try {
      final response = await DioClient.instance.get(
        '/trending/person/${timeWindow.name}',
        queryParameters: {'language': languageId, 'page': page},
      );

      if (response.isEmpty) {
        return (0, <PersonEntity>[]);
      }
      final personResponse = DataPersonList.fromJson(response);

      return (
        personResponse.page,
        personResponse.results.map((e) => e.toPersonEntity()).toList(),
      );
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }
}
