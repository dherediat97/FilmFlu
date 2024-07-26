import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:film_flu/presentation/features/media_list/widgets/media_carrousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaList extends StatefulWidget {
  const MediaList({
    super.key,
    required this.mediaType,
    required this.genreId,
    required this.title,
  });

  final String mediaType;
  final String title;
  final int genreId;

  @override
  State<MediaList> createState() => _MediaDataList();
}

class _MediaDataList extends State<MediaList> {
  final int _currentPage = 1;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
    context.read<MediaListBloc>().add(
        MediaListEvent.getMediaDataByGenre(widget.mediaType, widget.genreId));
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
      context.read<MediaListBloc>().add(MediaListEvent.nextPage(_currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaListBloc, MediaListState>(
      builder: (context, state) {
        return Column(
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
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: widget.mediaType == MediaListConstants.movieMediaType
                    ? state.movies?.length
                    : state.series?.length,
                itemBuilder: (context, index) {
                  return MediaCarrouselItem(
                    mediaItem:
                        widget.mediaType == MediaListConstants.movieMediaType
                            ? state.movies![index]
                            : state.series![index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  nextPage(int genreId, String mediaType) {
    context.read<MediaListBloc>().add(
          MediaListEvent.loadMoreMediaData(
            mediaType,
            genreId,
          ),
        );
  }
}
