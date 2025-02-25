import 'package:film_flu/data/repositories/person_repository_impl.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'person_repository.g.dart';

@riverpod
PersonRepository personRepository(ref) => PersonRepositoryImpl();

abstract interface class PersonRepository {
  Future<PersonEntity> fetchPersonData(
    String personId,
  );
}
