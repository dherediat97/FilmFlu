import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/domain/enums/genre_ids.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/domain/enums/sort_options.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:film_flu/presentation/view_models/media_list_view_model.dart';
import 'package:film_flu/presentation/features/media_list/widgets/media_carrousel_item.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaList extends ConsumerStatefulWidget {
  const MediaList({
    super.key,
    required this.genreId,
    required this.title,
    required this.mediaType,
    this.sortOption = SortOptions.popularity,
  });

  final MediaType mediaType;
  final String title;
  final GenreIds genreId;
  final SortOptions sortOption;

  @override
  ConsumerState<MediaList> createState() => _MediaDataList();
}

class _MediaDataList extends ConsumerState<MediaList> {
  final CarouselController _carouselController = CarouselController();

  MediaListViewModel get viewModel => ref.read(
    mediaListViewModelProvider(
      MediaFilter(
        mediaTypeSelected: widget.mediaType,
        genredId: widget.genreId,
        languageId: context.localizations.localeName,
        sortBy: widget.sortOption,
      ),
    ).notifier,
  );

  MediaFilterNotifier get mediaFilterController => ref.read(
    mediaFilterProvider(
      MediaFilter(
        mediaTypeSelected: widget.mediaType,
        genredId: widget.genreId,
        languageId: context.localizations.localeName,
        sortBy: widget.sortOption,
      ),
    ).notifier,
  );

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
    final mediaFilter = ref.watch(
      mediaFilterProvider(
        MediaFilter(
          mediaTypeSelected: widget.mediaType,
          genredId: widget.genreId,
          languageId: context.localizations.localeName,
          sortBy: widget.sortOption,
        ),
      ),
    );
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
        padding: EdgeInsets.all(12),
        child: mediaWidgetList(state),
      ),
    );
  }

  mediaWidgetList(AsyncValue<List<MediaSimpleItemEntity>> state) {
    final items = state.valueOrNull ?? [];
    final icon =
        GenreIds.values
            .firstWhere((element) => element.id == widget.genreId.id)
            .icon;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            SizedBox(width: 20),
            AutoSizeText(
              widget.title,
              maxFontSize: 30,
              minFontSize: 20,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            // IconButton(
            //   tooltip: widget.sortOption.name,
            //   onPressed: () => _changeSort(),
            //   icon: Icon(Icons.sort),
            // ),
          ],
        ),
        const SizedBox(height: 20),
        if (widget.mediaType == MediaType.movie)
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 230),
            child: CarouselView(
              shrinkExtent: 10,
              itemSnapping: true,
              controller: _carouselController,
              padding: const EdgeInsets.all(12),
              itemExtent: 150,
              onTap: (index) {
                final movie = items[index];
                FirebaseAnalytics.instance.logScreenView(
                  screenName: 'details_media_item',
                );

                FirebaseAnalytics.instance.logEvent(
                  name: 'view_details',
                  parameters: {'mediaType': widget.mediaType.name},
                );

                MovieRoute(id: movie.id).push(context);
              },
              children: List.generate(items.length, (int index) {
                return MediaCarrouselItem(mediaItem: items[index]);
              }),
            ),
          ),
        if (widget.mediaType == MediaType.tv)
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 230),
            child: CarouselView(
              itemSnapping: true,
              padding: const EdgeInsets.all(12),
              itemExtent: 150,
              controller: _carouselController,
              onTap: (index) {
                final tvSerie = items[index];
                FirebaseAnalytics.instance.logScreenView(
                  screenName: 'details_media_item',
                );
                FirebaseAnalytics.instance.logEvent(
                  name: 'view_details',
                  parameters: {'mediaType': widget.mediaType.name},
                );
                SerieRoute(id: tvSerie.id).push(context);
              },
              children: List.generate(items.length, (int index) {
                return MediaCarrouselItem(mediaItem: items[index]);
              }),
            ),
          ),
      ],
    );
  }

  // _changeSort() {
  //   var sortOption = SortOptions.movieDate;
  //   mediaFilterController.updateOrder(sortOption);
  //   viewModel.loadPage(1, mediaFilterController.arg);
  // }

  _loadMore() {
    final offset = _carouselController.offset;
    final maxOffset = _carouselController.position.maxScrollExtent;
    final isOutOfRange = _carouselController.position.outOfRange;
    final hasReachedTheEnd = offset >= maxOffset && !isOutOfRange;

    if (hasReachedTheEnd) {
      viewModel.loadNextPage(
        ref.read(
          mediaFilterProvider(
            MediaFilter(
              mediaTypeSelected: widget.mediaType,
              genredId: widget.genreId,
              languageId: context.localizations.localeName,
              sortBy: widget.sortOption,
            ),
          ),
        ),
      );
    }
  }
}
