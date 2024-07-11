import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/media_list/widgets/media_carrousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaDataList extends StatefulWidget {
  const MediaDataList({
    super.key,
    required this.genreId,
    required this.mediaType,
    required this.mediaItemList,
  });

  final String mediaType;
  final int genreId;
  final List<MediaItemEntity> mediaItemList;

  @override
  State<MediaDataList> createState() => _MediaDataList();
}

class _MediaDataList extends State<MediaDataList> {
  final _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _currentPage++;
        nextPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaListBloc, MediaListState>(
      listenWhen: (previous, current) {
        return _currentPage != 1;
      },
      listener: (context, state) {
        nextPage();
      },
      builder: (context, state) {
        return Scaffold(
          body: ListView.builder(
            controller: _scrollController,
            itemCount: _currentPage == 1
                ? widget.mediaItemList.length
                : state.mediaList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return MovieCarrouselItem(
                movie: _currentPage == 1
                    ? widget.mediaItemList[index]
                    : state.mediaList[index],
              );
            },
          ),
        );
      },
    );
  }

  nextPage() {
    context.read<MediaListBloc>().add(MediaListEvent.loadMoreMediaData(
          widget.mediaType,
          _currentPage,
          widget.genreId,
        ));
  }
}
