import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class MediaCarrouselItem extends StatelessWidget {
  const MediaCarrouselItem({
    super.key,
    required this.mediaItem,
    required this.mediaTypeSelected,
  });

  final MediaSimpleItemEntity? mediaItem;
  final MediaType mediaTypeSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          key: key,
          width: 140,
          height: 200,
          child: CachedNetworkImage(
            imageUrl: '${AppUrls.movieImgBaseURL}${mediaItem?.posterPath}',
            imageBuilder: (context, imageProvider) => Container(
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
