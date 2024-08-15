import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:flutter/material.dart';

class InfoMedia extends StatelessWidget {
  const InfoMedia({
    super.key,
    required this.mediaItem,
    required this.media,
  });

  final MediaItemEntity? mediaItem;
  final MediaResponseEntity? media;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (mediaItem!.overview != null)
          Text(
            mediaItem!.overview!.toString(),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        if (media != null) ...[
          Column(
            children: [
              const Text('Posteres de la pelicula'),
              GridView.custom(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 240,
                  mainAxisExtent: 340,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: media?.backdrops?.length,
                  (_, index) {
                    print(
                        '${AppUrls.movieLandscapeBaseUrl}${media?.backdrops?[index].filePath}');
                    return CachedNetworkImage(
                      imageUrl:
                          '${AppUrls.movieLandscapeBaseUrl}${media?.backdrops?[index].filePath}',
                      // height: media!.backdrops![index].height,
                      // width: media!.backdrops![index].width,
                    );
                  },
                ),
              ),
              // GridView.builder(
              //   itemCount: media?.posters?.length,
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3),
              //   itemBuilder: (context, index) {
              //     return CachedNetworkImage(
              //       imageUrl: media!.posters![index].filePath,
              //       height: media!.posters![index].height,
              //       width: media!.posters![index].width,
              //     );
              //   },
              // )
            ],
          ),
        ]
      ],
    );
  }
}
