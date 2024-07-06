import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/custom_loading.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
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
              AppConstants.mediaType = movie.title != ''
                  ? MediaListConstants.movieMediaType
                  : MediaListConstants.serieMediaType;

              AppConstants.mediaTypeId = movie.id;
              context.push('${AppRoutePaths.mediaDetails}/${movie.id}');
            },
            child: SizedBox(
              width: 140,
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32),
                  ),
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
      ),
    );
  }
}
