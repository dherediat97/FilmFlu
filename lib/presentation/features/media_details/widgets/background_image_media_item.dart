import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/core/utils/util_date.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:film_flu/presentation/widgets/default_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackgroundImageMediaItem extends StatelessWidget {
  const BackgroundImageMediaItem({
    super.key,
    required this.mediaItem,
    required this.movieName,
    required this.isHomeScreen,
    required this.productionCompanyImage,
  });

  final String productionCompanyImage;
  final MediaItemEntity? mediaItem;
  final String movieName;
  final bool isHomeScreen;

  @override
  Widget build(BuildContext context) {
    return mediaItem != null
        ? SliverAppBar(
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.of(context).size.height / 1.20,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  DefaultImageWidget(
                    darkenImage: true,
                    imageUrl:
                        '${AppUrls.movieLandscapeBaseUrl}${mediaItem!.backdropPath}',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (productionCompanyImage.isNotEmpty)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.network(
                                height: 32,
                                width: 120,
                                alignment: Alignment.topRight,
                                '${AppUrls.providerImgBaseUrl}$productionCompanyImage',
                              ),
                            ],
                          ),
                        Text(
                          movieName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${(mediaItem!.voteAverage!.round() * 10)}% de los usuarios les gusta',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.greenAccent,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (mediaItem?.releaseDate != null) ...[
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
                                getYear(mediaItem!.releaseDate!)!,
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
                                      AppConstants.mediaType = mediaItem!
                                                  .title !=
                                              ''
                                          ? MediaListConstants.movieMediaType
                                          : MediaListConstants.serieMediaType;

                                      AppConstants.mediaTypeId = mediaItem!.id;

                                      context.push(
                                          '${AppRoutePaths.mediaDetailsRoute}/${mediaItem?.id}');
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
            ),
          )
        : SliverToBoxAdapter(child: Container());
  }
}
