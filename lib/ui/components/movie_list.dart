import 'package:FilmFlu/dto/media_item.dart';
import 'package:FilmFlu/ui/components/movie_carrousel_item.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  MovieList({super.key, required this.items});

  late List<MediaItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Builder(
          builder: (BuildContext context) {
            return MovieCarrouselItem(movie: items[index]);
          },
        );
      },
    );
  }
}
