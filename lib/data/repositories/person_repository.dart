import 'package:FilmFlu/app/types/errors/network_error.dart';
import 'package:FilmFlu/app/types/repository_error.dart';
import 'package:FilmFlu/app/types/result.dart';
import 'package:FilmFlu/data/models/person_remote_entity.dart';
import 'package:FilmFlu/data/repositories/remote/person_remote_data_source_contract.dart';
import 'package:FilmFlu/domain/models/person_entity.dart';
import 'package:FilmFlu/domain/repository_contracts/person_repository_contract.dart';

class PersonRepository implements PersonRepositoryContract {
  final PersonRemoteDataSourceContract _personRemoteDataSourceContract;

  PersonRepository(
    this._personRemoteDataSourceContract,
  );

  @override
  Future<Result<PersonEntity>> fetchPersonData(
    String personId,
  ) async {
    try {
      final personData = await _personRemoteDataSourceContract.fetchPersonData(
        personId,
      );

      return Result.success(personData.toPersonEntity());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }
}
