import 'package:FilmFlu/modules/movies/domain/entities/media_item.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_list/movie_carrousel_item.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  MovieList({super.key, required this.items});

  final List<MediaItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return MovieCarrouselItem(movie: items[index]);
      },
    );
  }
}
