import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:octo_image/octo_image.dart';

class MediaCarrouselItem extends StatelessWidget {
  const MediaCarrouselItem({
    super.key,
    required this.mediaItem,
  });

  final MediaItemEntity? mediaItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              AppConstants.mediaType = mediaItem?.title != ''
                  ? MediaListConstants.movieMediaType
                  : MediaListConstants.serieMediaType;

              AppConstants.mediaTypeId = mediaItem!.id;
              context
                  .push('${AppRoutePaths.mediaDetailsRoute}/${mediaItem?.id}');
            },
            child: SizedBox(
              width: 140,
              height: 200,
              child: mediaItem != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: OctoImage(
                              image: CachedNetworkImageProvider(
                                '${AppUrls.movieImgBaseURL}${mediaItem?.posterPath}',
                              ),
                              progressIndicatorBuilder: OctoProgressIndicator
                                  .circularProgressIndicator(),
                            ).image),
                      ),
                    )
                  : const PlaceholderLoader(),
            ),
          ),
        ],
      ),
    );
  }
}
