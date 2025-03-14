import 'dart:async';

import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/use_case/media_use_case.dart';
import 'package:film_flu/domain/use_case/provider.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:film_flu/presentation/notifiers/base/pagination_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mediaListViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<MediaListViewModel, List<MediaSimpleItemEntity>, MediaFilter>(
      MediaListViewModel.new,
    );

class MediaListViewModel
    extends
        AutoDisposeFamilyAsyncNotifier<List<MediaSimpleItemEntity>, MediaFilter>
    with
        AsyncPaginationController<MediaSimpleItemEntity, int, MediaFilter>,
        AsyncPaginationFilter<MediaFilter, MediaSimpleItemEntity, int> {
  MediaUseCase get repository => ref.read(mediaProvider);

  var _canLoadMore = true;

  get canLoadMore => _canLoadMore;

  @override
  int get initialPage => 1;

  @override
  FutureOr<List<MediaSimpleItemEntity>> loadPage(
    int page,
    MediaFilter currentFilter,
  ) async {
    final (totalItems, items) = await repository.getMediaDataByGenre(
      currentFilter.mediaTypeSelected,
      currentFilter.genredId,
      currentFilter.languageId,
      page,
      currentFilter.sortBy.name,
    );
    final previousLength = state.valueOrNull?.length ?? 0;
    _canLoadMore = previousLength + items.length < totalItems;
    return items;
  }

  @override
  int nextPage(int currentPage) => currentPage + 1;

  void refresh() {
    currentPage = initialPage;
  }
}
