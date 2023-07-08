import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmflu/dto/movie.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: CarouselSlider(
          items: movies.map((movie) {
            return Builder(builder: (BuildContext context) {
              print(
                  "https://www.themoviedb.org/t/p/w300_and_h450_bestv2${movie.posterPath}");
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Image.network(
                        "https://www.themoviedb.org/t/p/w300_and_h450_bestv2${movie.posterPath}"),
                    Text(movie.title)
                  ],
                ),
              );
            });
          }).toList(),
          options: CarouselOptions(
            height: 1080,
            viewportFraction: 0.5,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
