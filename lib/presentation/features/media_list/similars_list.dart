import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:film_flu/presentation/features/media_list/widgets/media_carrousel_item.dart';
import 'package:film_flu/presentation/view_models/similar_list_view_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimilarsList extends ConsumerStatefulWidget {
  const SimilarsList({
    super.key,
    required this.mediaType,
    required this.mediaTypeId,
  });

  final String mediaType;
  final int mediaTypeId;

  @override
  ConsumerState<SimilarsList> createState() => _MediaDataList();
}

class _MediaDataList extends ConsumerState<SimilarsList> {
  final CarouselController _carouselController = CarouselController();

  SimilarListViewModel get viewModel => ref.read(
    similarListViewModelProvider(
      SimilarMediaFilter(
        mediaTypeSelected: widget.mediaType,
        mediaTypeId: widget.mediaTypeId,
        languageId: context.localizations.localeName,
      ),
    ).notifier,
  );

  SimilarMediaFilterNotifier get similarMediaFilterController => ref.read(
    similarMediaFilterProvider(
      SimilarMediaFilter(
        mediaTypeSelected: widget.mediaType,
        mediaTypeId: widget.mediaTypeId,
        languageId: context.localizations.localeName,
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
    final similarMediaFilter = ref.watch(
      similarMediaFilterProvider(
        SimilarMediaFilter(
          mediaTypeSelected: widget.mediaType,
          languageId: context.localizations.localeName,
          mediaTypeId: widget.mediaTypeId,
        ),
      ),
    );

    final state = ref.watch(similarListViewModelProvider(similarMediaFilter));

    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.axisDirection == AxisDirection.down &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent) {
          if (viewModel.canLoadMore) {
            viewModel.loadNextPage(similarMediaFilter);
          }
        }
        return true;
      },
      child: Padding(padding: EdgeInsets.all(2), child: mediaWidgetList(state)),
    );
  }

  mediaWidgetList(AsyncValue<List<MediaSimpleItemEntity>> state) {
    final items = state.valueOrNull ?? [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.mediaType == MediaType.movie.name)
          SizedBox(
            height: 230,
            child: CarouselView(
              controller: _carouselController,
              itemSnapping: true,
              padding: const EdgeInsets.all(12),
              itemExtent: 150,
              onTap: (index) {
                final movie = items[index];
                FirebaseAnalytics.instance.logScreenView(
                  screenName: 'details_media_item',
                );

                FirebaseAnalytics.instance.logEvent(
                  name: 'view_details',
                  parameters: {'mediaType': widget.mediaType},
                );

                MovieRoute(id: movie.id).push(context);
              },
              children: List.generate(items.length, (int index) {
                return MediaCarrouselItem(mediaItem: items[index]);
              }),
            ),
          ),
        if (widget.mediaType == MediaType.tv.name)
          SizedBox(
            height: 230,
            child: CarouselView(
              controller: _carouselController,
              itemSnapping: true,
              padding: const EdgeInsets.all(12),
              itemExtent: 150,
              onTap: (index) {
                final tvSerie = items[index];

                FirebaseAnalytics.instance.logScreenView(
                  screenName: 'details_media_item',
                );
                FirebaseAnalytics.instance.logEvent(
                  name: 'view_details',
                  parameters: {'mediaType': widget.mediaType},
                );
                SerieRoute(id: tvSerie.id).go(context);
              },
              children: List.generate(items.length, (int index) {
                return MediaCarrouselItem(mediaItem: items[index]);
              }),
            ),
          ),
      ],
    );
  }

  _loadMore() {
    final offset = _carouselController.offset;
    final maxOffset = _carouselController.position.maxScrollExtent;
    final isOutOfRange = _carouselController.position.outOfRange;
    final hasReachedTheEnd = offset >= maxOffset && !isOutOfRange;

    if (hasReachedTheEnd) {
      viewModel.loadNextPage(
        ref.read(
          similarMediaFilterProvider(
            SimilarMediaFilter(
              mediaTypeSelected: widget.mediaType,
              mediaTypeId: widget.mediaTypeId,
              languageId: context.localizations.localeName,
            ),
          ),
        ),
      );
    }
  }
}
