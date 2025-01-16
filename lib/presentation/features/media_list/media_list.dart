import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/data/models/media_type.dart';
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
  int _currentPage = 1;
  final CarouselController _carouselController = CarouselController();

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
    final state = ref.watch(mediaListViewModelProvider);

    return state.map(
      error: (error) => Text(error.toString()),
      data: (data) {
        return Padding(
          key: widget.key,
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                        '${AppRoutePaths.moviesRoute}/${data.value[index].id}',
                      );
                    },
                    children: List<Widget>.generate(
                      data.value.length,
                      (int index) {
                        return MediaCarrouselItem(
                          mediaItem: data.value[index],
                          mediaTypeSelected: MediaType.movie,
                        );
                      },
                    ),
                  ),
                ),
              if (widget.mediaType == MediaType.tv)
                CarouselView(
                  padding: const EdgeInsets.all(8.0),
                  itemExtent: 360,
                  controller: _carouselController,
                  onTap: (index) {
                    context.push(
                        '${AppRoutePaths.seriesRoute}/${data.value[index].id}');
                  },
                  children: List<Widget>.generate(
                    data.value.length,
                    (int index) {
                      return MediaCarrouselItem(
                        mediaItem: data.value[index],
                        mediaTypeSelected: MediaType.tv,
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
      loading: (loading) {
        return Shimmer(
          child: buildTopRowList(),
        );
      },
    );
  }

  void _loadMore() {
    final offset = _carouselController.offset;
    final maxOffset = _carouselController.position.maxScrollExtent;
    final isOutOfRange = _carouselController.position.outOfRange;
    final hasReachedTheEnd = offset >= maxOffset && !isOutOfRange;

    if (hasReachedTheEnd) {
      _currentPage++;
      log(_currentPage);
    }
  }
}
