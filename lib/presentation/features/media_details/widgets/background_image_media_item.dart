import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/widgets/default_image_loader.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
import 'package:flutter/material.dart';

class BackgroundImageMediaItem extends StatelessWidget {
  const BackgroundImageMediaItem({
    super.key,
    this.mediaItem,
    required this.movieName,
    required this.isHomeScreen,
  });

  final MediaItemEntity? mediaItem;
  final String movieName;
  final bool isHomeScreen;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 0,
      automaticallyImplyLeading: false,
      expandedHeight: MediaQuery.of(context).size.height / 1.20,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(fit: StackFit.expand, children: [
          mediaItem != null
              ? DefaultImageLoader(
                  darkenImage: true,
                  imageUrl:
                      '${AppUrls.movieLandscapeBaseUrl}${mediaItem?.backdropPath}',
                )
              : const PlaceholderLoader(),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    Text(
                      'Añadir a mi lista',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    )
                  ],
                ),
                if (isHomeScreen) ...[
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.info_outline, color: Colors.white),
                      Text(
                        'Información',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      )
                    ],
                  ),
                ],
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
