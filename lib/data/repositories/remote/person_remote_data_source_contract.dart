import 'package:film_flu/data/models/person_remote_entity.dart';

abstract class PersonRemoteDataSourceContract {
  Future<PersonRemoteEntity> fetchPersonData(
    String personId,
  );
}
