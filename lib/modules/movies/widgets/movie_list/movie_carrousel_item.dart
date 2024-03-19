//Core Packages
import 'package:FilmFlu/modules/movies/domain/entities/detailsMovieArguments.dart';
import 'package:flutter/material.dart';

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
                Navigator.pushNamed(context, "/movieDetails",
                    arguments: DetailsMovieArguments(
                        movieId: movie.id.toString(),
                        mediaType: movie.mediaType!));
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
