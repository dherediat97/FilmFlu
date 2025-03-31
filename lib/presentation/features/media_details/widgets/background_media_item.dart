import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/core/utils/util_date.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/genres_list_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class BackgroundMediaItem extends StatefulWidget {
  const BackgroundMediaItem({
    super.key,
    required this.mediaItem,
    required this.isHomeScreen,
    required this.title,
  });

  final String title;
  final MediaItemEntity mediaItem;
  final bool isHomeScreen;

  @override
  State<BackgroundMediaItem> createState() => _BackgroundMediaItemState();
}

class _BackgroundMediaItemState extends State<BackgroundMediaItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Stack(
        children: [
          BackgroundImageMediaItem(
            imageUrl:
                '${AppUrls.movieLandscapeBaseUrl}${widget.mediaItem.backdropPath}',
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  widget.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  minFontSize: 10,
                  stepGranularity: 10,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                Chip(
                  backgroundColor: Colors.yellowAccent,
                  padding: EdgeInsets.all(8.0),
                  label: Text(
                    '${(widget.mediaItem.voteAverage?.floorToDouble())}/10',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  avatar: Icon(Icons.star, color: Colors.black, size: 24),
                ),

                if (widget.mediaItem.genres.isNotEmpty) ...[
                  GenresListWidget(genres: widget.mediaItem.genres),
                ],

                if (widget.mediaItem.releaseDate.isNotEmpty &&
                    widget.mediaItem.firstAirDate.isNotEmpty) ...[
                  const SizedBox(width: 20),
                  Text(
                    getYear(widget.mediaItem) ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
                if (widget.isHomeScreen) ...[
                  const Spacer(),
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              MediaType mediaTypeSelected =
                                  widget.mediaItem.title != ''
                                      ? MediaType.movie
                                      : MediaType.tv;

                              FirebaseAnalytics.instance.logScreenView(
                                screenName: 'details_media_item',
                              );

                              FirebaseAnalytics.instance.logEvent(
                                name: 'view_details',
                                parameters: {
                                  'mediaType': mediaTypeSelected.name,
                                },
                              );

                              mediaTypeSelected == MediaType.movie
                                  ? MovieRoute(
                                    id: widget.mediaItem.id,
                                  ).push(context)
                                  : SerieRoute(
                                    id: widget.mediaItem.id,
                                  ).push(context);
                            },
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            context.localizations.information,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
