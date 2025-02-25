import 'package:film_flu/data/models/media_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_filter_notifier.freezed.dart';

final mediaFilterProvider = NotifierProvider.family
    .autoDispose<MediaFilterNotifier, MediaFilter, MediaFilter>(
  MediaFilterNotifier.new,
);

@freezed
class MediaFilter with _$MediaFilter {
  const factory MediaFilter({
    required MediaType mediaTypeSelected,
    required int genredId,
    required String languageId,
  }) = _MediaFilter;
}

class MediaFilterNotifier
    extends AutoDisposeFamilyNotifier<MediaFilter, MediaFilter> {
  @override
  MediaFilter build(MediaFilter filter) => filter;

  void updateGenre(int genredId) {
    state = state.copyWith(genredId: genredId);
  }

  void update(MediaFilter filter) {
    state = filter;
  }
}
