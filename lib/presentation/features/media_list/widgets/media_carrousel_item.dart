import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:flutter/material.dart';

class MediaCarrouselItem extends StatelessWidget {
  const MediaCarrouselItem({super.key, required this.mediaItem});

  final MediaSimpleItemEntity? mediaItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          key: key,
          width: 150,
          height: 204,
          child: CachedNetworkImage(
            imageUrl: '${AppUrls.movieImgBaseURL}${mediaItem?.posterPath}',
            imageBuilder:
                (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ],
    );
  }
}
