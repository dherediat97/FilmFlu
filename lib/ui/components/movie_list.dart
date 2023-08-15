import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/ui/components/movie_carrousel_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.movies});

  final List<Movie> movies;

  final aspectRatio = kIsWeb ? 16 / 9 : 1.5;
  final viewportFraction = kIsWeb ? 0.2 : 0.8;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: ScrollController(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 500,
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return Builder(
                      builder: (BuildContext context) {
                        return MovieCarrouselItem(movie: movies[index]);
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
