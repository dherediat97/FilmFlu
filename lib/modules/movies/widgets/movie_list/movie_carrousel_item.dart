//Core Packages
import 'package:FilmFlu/modules/movies/widgets/movie_detail/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

//My Packages
import 'package:FilmFlu/modules/movies/domain/entities/media_item.dart';
import 'package:FilmFlu/core/constants/constants.dart';
import 'package:FilmFlu/core/extensions/loading_extension.dart';

class MovieCarrouselItem extends StatelessWidget {
  const MovieCarrouselItem({super.key, required this.movie});

  final MediaItem movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                var isFilm = movie.firstAirDate == null ? true : false;
                Navigator.pushNamed(context, "/movieDetails",
                    arguments: DetailsMovieArguments(
                        movieId: movie.id.toString(), isFilm: isFilm));
              },
              child: SizedBox(
                width: 140,
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: Image.network(
                        '$movieImgBaseURL${movie.posterPath}',
                        loadingBuilder: (context, child, loadingProgress) =>
                            DefaultAsyncLoading(
                          child: child,
                          loadingProgress: loadingProgress,
                        ),
                      ).image,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
