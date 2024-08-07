import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              AppConstants.mediaTypeId = mediaItem!.id;
              context
                  .push('${AppRoutePaths.mediaDetailsRoute}/${mediaItem?.id}');
            },
            child: SizedBox(
              width: 140,
              height: 200,
              child: mediaItem != null
                  ? CachedNetworkImage(
                      imageUrl:
                          '${AppUrls.movieImgBaseURL}${mediaItem?.posterPath}',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: PlaceholderLoader()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : const PlaceholderLoader(),
            ),
          ),
        ],
      ),
    );
  }
}
