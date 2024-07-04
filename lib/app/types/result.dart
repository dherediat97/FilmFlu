import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:film_flu/app/types/repository_error.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.failure({required RepositoryError error}) = Failure<T>;
  const factory Result.success(T data) = Success<T>;
}
