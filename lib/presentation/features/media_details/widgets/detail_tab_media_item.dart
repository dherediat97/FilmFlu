import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/container_tab_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/info_media.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_data_cast.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_data_production.dart';
import 'package:film_flu/presentation/features/media_details/widgets/reviews_widget_item.dart';
import 'package:film_flu/presentation/notifiers/media_detail_notifier.dart';
import 'package:film_flu/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailTabMediaItem extends ConsumerStatefulWidget {
  const DetailTabMediaItem({
    super.key,
    required this.mediaTypeSelected,
    required this.mediaItemId,
  });

  final String mediaTypeSelected;
  final String mediaItemId;

  @override
  ConsumerState<DetailTabMediaItem> createState() => _DetailTabMediaItem();
}

class _DetailTabMediaItem extends ConsumerState<DetailTabMediaItem>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      var index = _tabController.index;
      switch (index) {
        case 0:
          ref.watch(getMediaItemDetailProvider(MediaItemState(
            id: widget.mediaItemId,
            mediaType: widget.mediaTypeSelected,
            languageName: context.localizations.localeName,
          )));
          setState(() {});
          break;
        case 1:
          ref.watch(getReviewsProvider(MediaItemState(
            mediaType: widget.mediaTypeSelected,
            id: widget.mediaItemId,
            languageName: context.localizations.localeName,
          )));
          break;
        case 2:
          ref.watch(getMediaCastProvider(CreditsMediaState(
            mediaType: widget.mediaTypeSelected,
            id: widget.mediaItemId,
            languageName: context.localizations.localeName,
            isCast: true,
          )));
          break;
        case 3:
          ref.watch(getMediaCastProvider(CreditsMediaState(
            mediaType: widget.mediaTypeSelected,
            id: widget.mediaItemId,
            languageName: context.localizations.localeName,
            isCast: false,
          )));
          break;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaItemResponse = ref.read(getMediaItemDetailProvider(
      MediaItemState(
          mediaType: widget.mediaTypeSelected,
          id: widget.mediaItemId,
          languageName: context.localizations.localeName),
    ));

    final item = mediaItemResponse.value;

    return SingleChildScrollView(
      child: Column(
        children: [
          item?.mediaItem == null
              ? Shimmer(child: buildMediaDayWidget(context))
              : BackgroundImageMediaItem(
                  title: item?.mediaItem?.title ?? '',
                  productionCompanyImage: item?.productionCompanyImage ?? '',
                  isHomeScreen: false,
                  mediaItem: item?.mediaItem,
                ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: DefaultTabController(
              length: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        text: context.localizations.information,
                      ),
                      Tab(text: context.localizations.reviews),
                      Tab(text: context.localizations.character_cast),
                      Tab(text: context.localizations.production_cast),
                    ],
                  ),
                  SizedBox(
                    height: 500,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ContainerTabMediaItem(
                          child: InfoMedia(
                            mediaItem: item?.mediaItem,
                            media: item?.mediaList,
                          ),
                        ),
                        item?.reviews == null
                            ? Column(
                                children: [
                                  Image.asset(
                                    AppAssets.emptyStateImage,
                                    height: 450,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  SizedBox(height: 20),
                                  Text('No hay reseñas'),
                                ],
                              )
                            : ContainerTabMediaItem(
                                child: ListView.builder(
                                  itemCount: item?.reviews?.length,
                                  itemBuilder: (context, index) {
                                    ReviewEntity? review =
                                        item?.reviews![index];

                                    return ReviewsWidgetItem(
                                      review: review,
                                    );
                                  },
                                ),
                              ),
                        ContainerTabMediaItem(
                          child: item?.cast == null
                              ? Shimmer(child: buildMediaDayWidget(context))
                              : MediaDataCast(
                                  cast: item?.cast ?? [],
                                ),
                        ),
                        ContainerTabMediaItem(
                          child: item?.crew == null
                              ? Shimmer(child: buildMediaDayWidget(context))
                              : MediaDataProduction(
                                  crew: item?.crew ?? [],
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
