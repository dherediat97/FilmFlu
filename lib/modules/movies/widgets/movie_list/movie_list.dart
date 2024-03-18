import 'package:FilmFlu/modules/movies/domain/entities/media_item.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_list/movie_carrousel_item.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  MovieList({super.key, required this.items, required this.scrollController});

  final List<MediaItem> items;
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
