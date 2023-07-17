import 'package:carousel_slider/carousel_slider.dart';
import 'package:FilmFlu/ui/components/movie_carrousel_item.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.items});

  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: items.map((item) {
          return Builder(builder: (BuildContext context) {
            return MovieCarrouselItem(movie: item);
          });
        }).toList(),
        options: CarouselOptions(viewportFraction: 0.3));
  }
}
