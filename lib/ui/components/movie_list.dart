import 'package:FilmFlu/dto/media_item.dart';
import 'package:FilmFlu/ui/components/movie_carrousel_item.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  MovieList({super.key, required this.items});

  final List<MediaItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemExtent: 200,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return MovieCarrouselItem(movie: items[index]);
      },
    );
  }
}
