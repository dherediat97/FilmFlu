import 'package:FilmFlu/app/constants/app_constants.dart';
import 'package:FilmFlu/app/constants/app_urls.dart';
import 'package:FilmFlu/app/extensions/custom_loading.dart';
import 'package:FilmFlu/app/routes/app_path.dart';
import 'package:FilmFlu/domain/models/media_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieCarrouselItem extends StatelessWidget {
  const MovieCarrouselItem({
    super.key,
    required this.movie,
  });

  final MediaItemEntity movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                AppConstants.mediaType = movie.mediaType.toString();
                AppConstants.mediaTypeId = movie.id.toString();

                context.push(
                  AppRoutePath.mediaDetails,
                  extra: {
                    'mediaId': movie.id,
                    'mediaType': movie.mediaType,
                  },
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
                        '${AppUrls.movieImgBaseURL}${movie.posterPath}',
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
