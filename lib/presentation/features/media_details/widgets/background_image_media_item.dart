import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/core/utils/util_date.dart';
import 'package:film_flu/domain/enums/genres_id.dart';
import 'package:film_flu/domain/enums/media_type.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/widgets/default_image_loader.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackgroundMediaItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Stack(
        children: [
          BackgroundImageMediaItem(
            imageUrl:
                '${AppUrls.movieLandscapeBaseUrl}${mediaItem.backdropPath}',
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                  minFontSize: 10,
                  stepGranularity: 10,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${(mediaItem.voteAverage!.round() * 10)}${context.localizations.percentange_vote}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.greenAccent,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                if (mediaItem.genres.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        List<Widget>.generate(mediaItem.genres.length, (
                          int index,
                        ) {
                          final firstGenre = index == 0;
                          final genre = mediaItem.genres[index];
                          final icon =
                              GenresId.values
                                  .firstWhere(
                                    (element) => element.id == genre.id,
                                  )
                                  .icon;
                          return Chip(
                            backgroundColor:
                                firstGenre
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.surface,
                            label: Text(
                              genre.name,
                              style: TextStyle(
                                color:
                                    firstGenre
                                        ? AppColors.backgroundColorLight
                                        : Theme.of(
                                          context,
                                        ).colorScheme.inverseSurface,
                                fontSize: 16,
                              ),
                            ),
                            avatar: Icon(
                              icon,
                              size: 24,
                              color:
                                  firstGenre
                                      ? AppColors.backgroundColorLight
                                      : Theme.of(context).colorScheme.primary,
                            ),
                          );
                        }).toList(),
                  ),
                ],
                if (mediaItem.releaseDate.isNotEmpty &&
                    mediaItem.firstAirDate.isNotEmpty) ...[
                  const SizedBox(width: 20),
                  Text(
                    getYear(mediaItem) ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
                if (isHomeScreen) ...[
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
                                  mediaItem.title != ''
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

                              context.push(
                                mediaTypeSelected == MediaType.movie
                                    ? '${AppRoutePaths.moviesRoute}/${mediaItem.id}'
                                    : '${AppRoutePaths.seriesRoute}/${mediaItem.id}',
                              );
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
