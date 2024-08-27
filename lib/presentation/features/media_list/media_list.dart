import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/widgets/media_carrousel_item.dart';
import 'package:film_flu/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MediaList extends StatefulWidget {
  const MediaList({
    super.key,
    required this.genreId,
    required this.title,
    required this.mediaType,
    this.languageId = 'es',
  });

  final MediaType mediaType;
  final String title;
  final String languageId;
  final int genreId;

  @override
  State<MediaList> createState() => _MediaDataList();
}

class _MediaDataList extends State<MediaList> {
  int _currentPage = 1;
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    _carouselController.addListener(_loadMore);

    context.read<MediaListBloc>().add(
          MediaListEvent.getMediaDataByGenre(
            widget.mediaType,
            widget.genreId,
            widget.languageId,
          ),
        );
  }

  @override
  void dispose() {
    _carouselController.removeListener(_loadMore);
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaListBloc, MediaListState>(
      buildWhen: (previous, current) {
        return !current.uiState.isLoading();
      },
      builder: (context, state) {
        List<MediaSimpleItemEntity>? mediaDataList =
            widget.mediaType == MediaType.movie
                ? state.movieData[widget.genreId]
                : state.serieData[widget.genreId];

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
                mediaDataList == null
                    ? Shimmer(
                        child: buildTopRowList(),
                      )
                    : SizedBox(
                        height: 220,
                        child: CarouselView(
                          padding: const EdgeInsets.all(8.0),
                          itemExtent: 180,
                          onTap: (index) {
                            context.push(
                              widget.mediaType == MediaType.movie
                                  ? '${AppRoutePaths.moviesRoute}/${mediaDataList[index].id}'
                                  : '${AppRoutePaths.seriesRoute}/${mediaDataList[index].id}',
                            );
                          },
                          children: List<Widget>.generate(
                            mediaDataList.length,
                            (int index) {
                              return MediaCarrouselItem(
                                mediaItem: mediaDataList[index],
                                mediaTypeSelected: MediaType.movie,
                              );
                            },
                          ),
                        ),
                      ),
              if (widget.mediaType == MediaType.tv)
                mediaDataList == null
                    ? Shimmer(
                        child: buildTopRowList(),
                      )
                    : SizedBox(
                        height: 220,
                        child: CarouselView(
                          padding: const EdgeInsets.all(8.0),
                          itemExtent: 180,
                          controller: _carouselController,
                          onTap: (index) {
                            context.push(widget.mediaType == MediaType.movie
                                ? '${AppRoutePaths.moviesRoute}/${mediaDataList[index].id}'
                                : '${AppRoutePaths.seriesRoute}/${mediaDataList[index].id}');
                          },
                          children: List<Widget>.generate(
                            mediaDataList.length,
                            (int index) {
                              return MediaCarrouselItem(
                                mediaItem: mediaDataList[index],
                                mediaTypeSelected: MediaType.tv,
                              );
                            },
                          ),
                        ),
                      ),
            ],
          ),
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
      context.read<MediaListBloc>().add(
            MediaListEvent.nextPage(
              _currentPage,
              widget.mediaType,
              widget.genreId,
            ),
          );
    }
  }
}
