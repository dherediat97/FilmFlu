import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
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
    return Column(children: [
      Container(
        height: 800,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
            image: Image.network(
              '${AppUrls.movieLandscapeBaseUrl}${mediaItem?.backdropPath}',
              fit: BoxFit.cover,
            ).image,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: AutoSizeText(
                      movieName,
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (mediaItem?.overview != null &&
                      mediaItem!.overview!.isNotEmpty) ...[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        context.localizations.synopsis,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      alignment: Alignment.topLeft,
                      child: AutoSizeText(
                        mediaItem!.overview!,
                        maxLines: 20,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
