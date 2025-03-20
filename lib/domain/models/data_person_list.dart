import 'package:film_flu/data/models/person_remote_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_person_list.freezed.dart';
part 'data_person_list.g.dart';

@freezed
class DataPersonList with _$DataPersonList {
  const factory DataPersonList({
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
    @JsonKey(name: 'results') required List<PersonRemoteEntity> results,
  }) = _DataPersonList;

  factory DataPersonList.fromJson(Map<String, dynamic> json) =>
      _$DataPersonListFromJson(json);
}
