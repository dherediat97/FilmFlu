import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/presentation/features/common/network_image_widget.dart';
import 'package:flutter/material.dart';

class MediaCarrouselItem extends StatefulWidget {
  const MediaCarrouselItem({super.key, required this.mediaItem});

  final MediaSimpleItemEntity? mediaItem;

  @override
  State<MediaCarrouselItem> createState() => _MediaCarrouselItemState();
}

class _MediaCarrouselItemState extends State<MediaCarrouselItem> {
  @override
  Widget build(BuildContext context) {
    return NetworkImageWidget(
      errorWidget: const SizedBox(
        height: 200,
        width: 200,
        child: Icon(Icons.error),
      ),
      imageUrl: '${AppUrls.movieImgBaseURL}${widget.mediaItem?.posterPath}',
      imageBuilder:
          (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
    );
  }
}
