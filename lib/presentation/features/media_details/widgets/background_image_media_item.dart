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
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(64),
              bottomRight: Radius.circular(64),
            ),
            child: Opacity(
              opacity: 0.4,
              child: Image.network(
                '${AppUrls.movieLandscapeBaseUrl}${mediaItem?.backdropPath}',
                width: MediaQuery.of(context).size.width,
                height: 600,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 32, top: 64),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  '${AppUrls.movieImgBaseURL}${mediaItem?.posterPath}',
                  width: 110,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 255,
            left: 155,
            child: SizedBox(
              child: Text(
                movieName,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
