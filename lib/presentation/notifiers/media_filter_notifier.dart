import 'package:film_flu/data/enums/genres_id.dart';
import 'package:film_flu/data/enums/media_type.dart';
import 'package:film_flu/data/enums/order_options.dart';
import 'package:film_flu/data/enums/sort_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_filter_notifier.freezed.dart';

final mediaFilterProvider = NotifierProvider.family
    .autoDispose<MediaFilterNotifier, MediaFilter, MediaFilter>(
  MediaFilterNotifier.new,
);

final mediaDayFilterProvider = NotifierProvider.family
    .autoDispose<MediaDayFilterNotifier, MediaDayFilter, MediaDayFilter>(
  MediaDayFilterNotifier.new,
);

@freezed
class MediaFilter with _$MediaFilter {
  const factory MediaFilter({
    required MediaType mediaTypeSelected,
    required GenresId genredId,
    required String languageId,
    @Default(SortOptions.popularity) SortOptions sortBy,
    @Default(OrderOptions.desc) OrderOptions orderBy,
  }) = _MediaFilter;
}

class MediaFilterNotifier
    extends AutoDisposeFamilyNotifier<MediaFilter, MediaFilter> {
  @override
  MediaFilter build(MediaFilter filter) => filter;

  void updateOrder(SortOptions sortBy) {
    state = state.copyWith(sortBy: sortBy);
  }

  void update(MediaFilter filter) {
    state = filter;
  }
}

@freezed
class MediaDayFilter with _$MediaDayFilter {
  const factory MediaDayFilter({
    required MediaType mediaTypeSelected,
    required String languageId,
    @Default(SortOptions.popularity) SortOptions sortBy,
    @Default(OrderOptions.desc) OrderOptions orderBy,
  }) = _MediaDayFilter;
}

class MediaDayFilterNotifier
    extends AutoDisposeFamilyNotifier<MediaDayFilter, MediaDayFilter> {
  @override
  MediaDayFilter build(MediaDayFilter filter) => filter;

  void update(MediaDayFilter filter) {
    state = filter;
  }
}
