import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:flutter/material.dart';

class BackgroundImageMediaItem extends StatelessWidget {
  const BackgroundImageMediaItem({
    super.key,
    this.mediaItem,
    required this.movieName,
  });

  final MediaItemEntity? mediaItem;
  final String movieName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(64),
            bottomRight: Radius.circular(64),
          ),
          child: Opacity(
            opacity: 0.6,
            child: Image.network(
              '${AppUrls.movieLandscapeBaseUrl}${mediaItem?.backdropPath}',
              width: MediaQuery.of(context).size.width,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 32, top: 64),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    '${AppUrls.movieImgBaseURL}${mediaItem?.posterPath}',
                    width: 110,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  movieName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
