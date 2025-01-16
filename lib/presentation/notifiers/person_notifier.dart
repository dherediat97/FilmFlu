import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/domain/repository/person_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'person_notifier.g.dart';

@riverpod
Future<PersonEntity> fetchPersonDetails(
  Ref ref,
  String personId,
) async {
  return await ref.watch(personRepositoryProvider).fetchPersonData(personId);
}
