import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/person_entity.dart';

abstract class PersonRepositoryContract {
  Future<Result<PersonEntity>> fetchPersonData(
    String personId,
  );
}
