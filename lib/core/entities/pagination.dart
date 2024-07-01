import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.g.dart';
part 'pagination.freezed.dart';

@freezed
@JsonSerializable(genericArgumentFactories: true)
class Pagination<T> with _$Pagination<T> {
  const factory Pagination({
    required List<T> results,
    int? page,
    int? totalPages,
    int? totalResults,
  }) = _Pagination<T>;

  factory Pagination.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$PaginationFromJson<T>(json, fromJsonT);
  }
}
