import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/routes/app_paths.dart';
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
    this.languageId = 'es',
  });

  final String title;
  final String languageId;
  final int genreId;

  @override
  State<MediaList> createState() => _MediaDataList();
}

class _MediaDataList extends State<MediaList> {
  int _currentPage = 1;
  MediaType mediaTypeSelected = MediaType.movie;
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    _carouselController.addListener(_loadMore);

    mediaTypeSelected = context.read<HomeBloc>().state.mediaTypeSelected;
    context.read<MediaListBloc>().add(
          MediaListEvent.getMediaDataByGenre(
            mediaTypeSelected,
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
      builder: (context, state) {
        List<MediaSimpleItemEntity>? mediaDataList =
            mediaTypeSelected == MediaType.movie
                ? state.movieData[widget.genreId]
                : state.serieData[widget.genreId];

        return mediaDataList == null
            ? Shimmer(
                child: buildTopRowList(),
              )
            : Padding(
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
                    if (mediaTypeSelected == MediaType.movie)
                      SizedBox(
                        height: 220,
                        child: CarouselView(
                          padding: const EdgeInsets.all(8.0),
                          itemExtent: 180,
                          onTap: (id) {
                            context.pushReplacement(
                                '${AppRoutePaths.mediaDetailsRoute}/${mediaTypeSelected.name}/${mediaDataList[id].id}');
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
                    if (mediaTypeSelected == MediaType.tv)
                      SizedBox(
                        height: 220,
                        child: CarouselView(
                          padding: const EdgeInsets.all(8.0),
                          itemExtent: 180,
                          controller: _carouselController,
                          onTap: (id) {
                            context.pushReplacement(
                                '${AppRoutePaths.mediaDetailsRoute}/${mediaTypeSelected.name}/${mediaDataList[id].id}');
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
              mediaTypeSelected,
              widget.genreId,
            ),
          );
    }
  }
}
