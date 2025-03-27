import 'package:film_flu/data/repositories/person_repository_impl.dart';
import 'package:film_flu/domain/enums/time_windows.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'person_repository.g.dart';

@riverpod
PersonRepository personRepository(ref) => PersonRepositoryImpl();

abstract interface class PersonRepository {
  Future<(int page, List<PersonEntity> items)> getTrendingPersons(
    TimeWindow timeWindow,
    String languageId,
    int page,
  );

  Future<PersonEntity> fetchPersonData(int personId, String languageCode);
}
