import 'package:film_flu/domain/enums/genre_ids.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/domain/enums/order_options.dart';
import 'package:film_flu/domain/enums/sort_options.dart';
import 'package:film_flu/domain/enums/time_windows.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_filter_notifier.freezed.dart';

final mediaFilterProvider = NotifierProvider.family
    .autoDispose<MediaFilterNotifier, MediaFilter, MediaFilter>(
      MediaFilterNotifier.new,
    );
final similarMediaFilterProvider = NotifierProvider.family.autoDispose<
  SimilarMediaFilterNotifier,
  SimilarMediaFilter,
  SimilarMediaFilter
>(SimilarMediaFilterNotifier.new);

final mediaDayFilterProvider = NotifierProvider.family
    .autoDispose<MediaDayFilterNotifier, MediaDayFilter, MediaDayFilter>(
      MediaDayFilterNotifier.new,
    );

final trendingPersonFilterProvider = NotifierProvider.family.autoDispose<
  TrendingPersonFilterNotifier,
  TrendingPersonFilter,
  TrendingPersonFilter
>(TrendingPersonFilterNotifier.new);

@freezed
class MediaFilter with _$MediaFilter {
  const factory MediaFilter({
    required MediaType mediaTypeSelected,
    required GenreIds genredId,
    required String languageId,
    @Default(SortOptions.popularity) SortOptions sortBy,
    @Default(OrderOptions.desc) OrderOptions orderBy,
  }) = _MediaFilter;
}

@freezed
class SimilarMediaFilter with _$SimilarMediaFilter {
  const factory SimilarMediaFilter({
    required String mediaTypeSelected,
    required String languageId,
    required int mediaTypeId,
  }) = _SimilarMediaFilter;
}

class SimilarMediaFilterNotifier
    extends AutoDisposeFamilyNotifier<SimilarMediaFilter, SimilarMediaFilter> {
  @override
  SimilarMediaFilter build(SimilarMediaFilter filter) => filter;

  void update(SimilarMediaFilter filter) {
    state = filter;
  }
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

@freezed
class TrendingPersonFilter with _$TrendingPersonFilter {
  const factory TrendingPersonFilter({
    required String languageId,
    required TimeWindow timeWindow,
  }) = _TrendingPersonFilter;
}

class TrendingPersonFilterNotifier
    extends
        AutoDisposeFamilyNotifier<TrendingPersonFilter, TrendingPersonFilter> {
  @override
  TrendingPersonFilter build(TrendingPersonFilter filter) => filter;

  void updateOrder(TimeWindow timeWindow) {
    state = state.copyWith(timeWindow: timeWindow);
  }

  void update(TrendingPersonFilter filter) {
    state = filter;
  }
}
