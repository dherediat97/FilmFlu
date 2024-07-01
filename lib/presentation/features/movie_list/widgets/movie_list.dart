import 'package:FilmFlu/domain/models/media_item_entity.dart';
import 'package:FilmFlu/presentation/features/movie_list/widgets/movie_carrousel_item.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
    required this.items,
    required this.scrollController,
  });

  final List<MediaItemEntity> items;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return MovieCarrouselItem(movie: items[index]);
      },
    );
  }
}
