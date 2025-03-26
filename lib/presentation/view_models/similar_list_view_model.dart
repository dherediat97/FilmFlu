import 'dart:async';

import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/use_case/media_use_case.dart';
import 'package:film_flu/domain/use_case/provider.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:film_flu/presentation/notifiers/base/pagination_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarListViewModelProvider = AsyncNotifierProvider.autoDispose.family<
  SimilarListViewModel,
  List<MediaSimpleItemEntity>,
  SimilarMediaFilter
>(SimilarListViewModel.new);

class SimilarListViewModel
    extends
        AutoDisposeFamilyAsyncNotifier<
          List<MediaSimpleItemEntity>,
          SimilarMediaFilter
        >
    with
        AsyncPaginationController<
          MediaSimpleItemEntity,
          int,
          SimilarMediaFilter
        >,
        AsyncPaginationFilter<SimilarMediaFilter, MediaSimpleItemEntity, int> {
  MediaUseCase get repository => ref.read(mediaProvider);

  var _canLoadMore = true;

  get canLoadMore => _canLoadMore;

  @override
  int get initialPage => 1;

  @override
  FutureOr<List<MediaSimpleItemEntity>> loadPage(
    int page,
    SimilarMediaFilter currentFilter,
  ) async {
    final (totalItems, items) = await repository.getSimilars(
      currentFilter.mediaTypeSelected,
      currentFilter.mediaTypeId,
      currentFilter.languageId,
      page,
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
