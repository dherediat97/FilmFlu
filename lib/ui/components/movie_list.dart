import 'package:FilmFlu/dto/movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:FilmFlu/ui/components/movie_carrousel_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.items});

  final List<Movie> items;

  final aspectRatio = kIsWeb ? 16 / 9 : 1.5;
  final viewportFraction = kIsWeb ? 0.2 : 0.8;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
          items: items.map((item) {
            return Builder(builder: (BuildContext context) {
              return MovieCarrouselItem(movie: item);
            });
          }).toList(),
          options: CarouselOptions(
            viewportFraction: viewportFraction,
            height: MediaQuery.of(context).size.height / 1.4,
          )),
    );
  }
}
