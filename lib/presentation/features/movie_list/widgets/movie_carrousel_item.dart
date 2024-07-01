import 'package:FilmFlu/app/constants/app_constants.dart';
import 'package:FilmFlu/app/extensions/custom_loading.dart';
import 'package:FilmFlu/domain/models/details_movie_arguments.dart';
import 'package:FilmFlu/domain/models/media_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieCarrouselItem extends StatelessWidget {
  const MovieCarrouselItem({super.key, required this.movie});

  final MediaItemEntity movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.pushNamed(
                  '/movieDetails',
                  extra: DetailsMovieArguments(
                    movieId: movie.id.toString(),
                    mediaType: movie.mediaType!,
                  ),
                );
              },
              child: SizedBox(
                width: 140,
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: Image.network(
                        '${AppConstants.movieImgBaseURL}${movie.posterPath}',
                        loadingBuilder: (context, child, loadingProgress) =>
                            DefaultAsyncLoading(
                          loadingProgress: loadingProgress,
                          child: child,
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
