import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/widgets/media_carrousel_item.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
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
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);

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
    _scrollController.removeListener(_loadMore);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    final offset = _scrollController.offset;
    final maxOffset = _scrollController.position.maxScrollExtent;
    final isOutOfRange = _scrollController.position.outOfRange;
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaListBloc, MediaListState>(
      builder: (context, state) {
        return state.uiState.map(
          initial: (e) => Container(),
          error: (e) => Container(),
          loading: (e) => const PlaceholderLoader(),
          success: (e) {
            List<MediaSimpleItemEntity>? mediaDataList =
                mediaTypeSelected == MediaType.movie
                    ? state.mediaData?.movieDataByGenre![widget.genreId]
                    : state.mediaData?.serieDataByGenre?[widget.genreId];

            return mediaDataList != null
                ? Padding(
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
                  )
                : Container();
          },
        );
      },
    );
  }
}
