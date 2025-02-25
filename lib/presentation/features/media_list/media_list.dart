import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:film_flu/presentation/view_models/media_list_view_model.dart';
import 'package:film_flu/presentation/widgets/media_carrousel_item.dart';
import 'package:film_flu/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MediaList extends ConsumerStatefulWidget {
  const MediaList({
    super.key,
    required this.genreId,
    required this.title,
    required this.mediaType,
  });

  final MediaType mediaType;
  final String title;
  final int genreId;

  @override
  ConsumerState<MediaList> createState() => _MediaDataList();
}

class _MediaDataList extends ConsumerState<MediaList> {
  final CarouselController _carouselController = CarouselController();

  MediaListViewModel get viewModel =>
      ref.read(mediaListViewModelProvider(MediaFilter(
        mediaTypeSelected: widget.mediaType,
        genredId: widget.genreId,
        languageId: context.localizations.localeName,
      )).notifier);

  MediaFilterNotifier get mediaFilterController => ref.read(mediaFilterProvider(
        MediaFilter(
          mediaTypeSelected: widget.mediaType,
          genredId: widget.genreId,
          languageId: context.localizations.localeName,
        ),
      ).notifier);

  @override
  void initState() {
    super.initState();
    _carouselController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _carouselController.removeListener(_loadMore);
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaFilter = ref.watch(mediaFilterProvider(MediaFilter(
      mediaTypeSelected: widget.mediaType,
      genredId: widget.genreId,
      languageId: context.localizations.localeName,
    )));
    final state = ref.watch(mediaListViewModelProvider(mediaFilter));

    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.axisDirection == AxisDirection.down &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent) {
          if (viewModel.canLoadMore) {
            viewModel.loadNextPage(mediaFilter);
          }
        }
        return true;
      },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: mediaWidgetList(state),
      ),
    );
  }

  mediaWidgetList(AsyncValue<List<MediaSimpleItemEntity>> state) {
    final items = state.valueOrNull ?? [];
    final initialLoading = state.isLoading && items.isEmpty;
    final loadingMore = state.isLoading && items.isNotEmpty;

    return initialLoading
        ? Shimmer(child: buildListItem(initialLoading))
        : loadingMore
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  AutoSizeText(
                    widget.title,
                    maxFontSize: 30,
                    minFontSize: 20,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  if (widget.mediaType == MediaType.movie)
                    SizedBox(
                      height: 220,
                      child: CarouselView(
                        controller: _carouselController,
                        padding: const EdgeInsets.all(8.0),
                        itemExtent: 180,
                        onTap: (index) {
                          context.push(
                            '${AppRoutePaths.moviesRoute}/${items[index].id}',
                          );
                        },
                        children: List.generate(
                          items.length,
                          (int index) {
                            return MediaCarrouselItem(
                              mediaItem: items[index],
                              mediaTypeSelected: MediaType.movie,
                            );
                          },
                        ),
                      ),
                    ),
                  if (widget.mediaType == MediaType.tv)
                    SizedBox(
                      height: 220,
                      child: CarouselView(
                        padding: const EdgeInsets.all(8.0),
                        itemExtent: 180,
                        controller: _carouselController,
                        onTap: (index) {
                          context.push(
                              '${AppRoutePaths.seriesRoute}/${items[index].id}');
                        },
                        children: List.generate(
                          items.length,
                          (int index) {
                            return MediaCarrouselItem(
                              mediaItem: items[index],
                              mediaTypeSelected: MediaType.tv,
                            );
                          },
                        ),
                      ),
                    ),
                ],
              );
  }

  void applyFilter() {
    viewModel.applyFilter(ref.read(mediaFilterProvider(MediaFilter(
      mediaTypeSelected: widget.mediaType,
      genredId: widget.genreId,
      languageId: context.localizations.localeName,
    ))));
  }

  void _loadMore() {
    final offset = _carouselController.offset;
    final maxOffset = _carouselController.position.maxScrollExtent;
    final isOutOfRange = _carouselController.position.outOfRange;
    final hasReachedTheEnd = offset >= maxOffset && !isOutOfRange;

    if (hasReachedTheEnd) {
      viewModel.loadNextPage(ref.read(mediaFilterProvider(MediaFilter(
        mediaTypeSelected: widget.mediaType,
        genredId: widget.genreId,
        languageId: context.localizations.localeName,
      ))));
    }
  }
}
