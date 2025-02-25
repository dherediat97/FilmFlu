import 'package:film_flu/data/datasources/remote/api/network/dio_client.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/domain/repository/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  @override
  Future<PersonEntity> fetchPersonData(
    String personId,
  ) async {
    final response = await DioClient.instance.get('/person/$personId');
    final person = PersonEntity.fromJson(response);
    return person;
  }
}
