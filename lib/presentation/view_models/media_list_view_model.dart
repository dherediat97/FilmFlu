import 'dart:async';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/use_case/media_use_case.dart';
import 'package:film_flu/domain/use_case/provider.dart';
import 'package:film_flu/presentation/notifiers/pagination_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mediaListViewModelProvider =
    AsyncNotifierProvider<MediaListViewModel, List<MediaSimpleItemEntity>>(
  () => MediaListViewModel(),
);

class MediaListViewModel extends AsyncNotifier<List<MediaSimpleItemEntity>>
    with AsyncPaginationController<MediaSimpleItemEntity, int, MediaFilter> {
  MediaUseCase get repository => ref.read(mediaProvider);

  var _canLoadMore = true;

  get canLoadMore => _canLoadMore;

  @override
  int get initialPage => 1;

  @override
  MediaFilter get initialFilter => MediaFilter(MediaType.movie, 28, 'es-ES');

  @override
  FutureOr<List<MediaSimpleItemEntity>> loadPage(
    int page,
    MediaFilter mediaFilter,
  ) async {
    final (totalItems, items) = await repository.getMovies(
      mediaFilter.genredId,
      mediaFilter.languageId,
    );
    final previousLength = state.valueOrNull?.length ?? 0;
    _canLoadMore = previousLength + items.length < totalItems;
    return items;
  }

  @override
  int nextPage(int currentPage) => currentPage + 1;
}

class MediaFilter {
  MediaType mediaTypeSelected;
  int genredId;
  String languageId;

  MediaFilter(
    this.mediaTypeSelected,
    this.genredId,
    this.languageId,
  );
}
