import 'package:FilmFlu/app/types/result.dart';
import 'package:FilmFlu/domain/models/person_entity.dart';

abstract class PersonRepositoryContract {
  Future<Result<PersonEntity>> fetchPersonData(
    String personId,
  );
}
