import 'package:film_flu/domain/enums/time_window.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/domain/repository/person_repository.dart';

abstract class PersonUseCase {
  Future<(int page, List<PersonEntity> items)> getTrendingPersons(
    TimeWindow timeWindow,
    String languageId,
    int page,
  );
}

class PersonUseCaseImpl extends PersonUseCase {
  final PersonRepository personRepository;

  PersonUseCaseImpl(this.personRepository);

  @override
  Future<(int page, List<PersonEntity> items)> getTrendingPersons(
    TimeWindow timeWindow,
    String languageId,
    int page,
  ) {
    return personRepository.getTrendingPersons(timeWindow, languageId, page);
  }
}
