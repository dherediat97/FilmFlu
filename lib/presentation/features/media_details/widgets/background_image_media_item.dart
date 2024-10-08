import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/core/utils/util_date.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_details/constants/media_detail_constants.dart';
import 'package:film_flu/presentation/widgets/default_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackgroundImageMediaItem extends StatelessWidget {
  const BackgroundImageMediaItem({
    super.key,
    required this.mediaItem,
    required this.isHomeScreen,
    required this.productionCompanyImage,
  });

  final String productionCompanyImage;
  final MediaItemEntity? mediaItem;
  final bool isHomeScreen;

  @override
  Widget build(BuildContext context) {
    return mediaItem != null
        ? SizedBox(
            height: MediaDetailConstants.mediaBackgroundHeight,
            child: Stack(children: [
              DefaultImageWidget(
                imageUrl:
                    '${AppUrls.movieLandscapeBaseUrl}${mediaItem?.backdropPath}',
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (productionCompanyImage.isNotEmpty)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.network(
                            width: MediaDetailConstants
                                .mediaProductionCompanySize.width,
                            height: MediaDetailConstants
                                .mediaProductionCompanySize.height,
                            fit: BoxFit.contain,
                            alignment: Alignment.topCenter,
                            '${AppUrls.providerImgBaseUrl}$productionCompanyImage',
                          ),
                        ],
                      ),
                    Text(
                      mediaItem!.title!.isNotEmpty
                          ? mediaItem!.title!
                          : mediaItem!.name!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(mediaItem!.voteAverage!.round() * 10)}${context.localizations.percentange_vote}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.greenAccent,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        if (mediaItem?.releaseDate != null &&
                            mediaItem?.firstAirDate != null) ...[
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.date_range_outlined,
                            size: 24,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            getYear(mediaItem!) ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ]
                      ],
                    ),
                    if (isHomeScreen) ...[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                context.localizations.add_to_my_list,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  MediaType mediaTypeSelected =
                                      mediaItem!.title != ''
                                          ? MediaType.movie
                                          : MediaType.tv;

                                  context.push(mediaTypeSelected ==
                                          MediaType.movie
                                      ? '${AppRoutePaths.moviesRoute}/${mediaItem?.id}'
                                      : '${AppRoutePaths.seriesRoute}/${mediaItem?.id}');
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
              )
            ]),
          )
        : Container();
  }
}
