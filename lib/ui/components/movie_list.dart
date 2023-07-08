import 'package:carousel_slider/carousel_slider.dart';
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/dto/tv_show.dart';
import 'package:FilmFlu/ui/components/movie_item.dart';
import 'package:FilmFlu/ui/components/tvshow_item.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.items});

  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
          items: items.map((item) {
            return Builder(builder: (BuildContext context) {
              if (item is Movie) {
                return MovieItem(movie: item);
              } else if (items is TvShow) {
                return TvShowItem(tvShow: item);
              } else {
                return Container();
              }
            });
          }).toList(),
          options: CarouselOptions(
            viewportFraction: 0.3,
            height: 470,
            aspectRatio: 16 / 9,
          )),
    );
  }
}
