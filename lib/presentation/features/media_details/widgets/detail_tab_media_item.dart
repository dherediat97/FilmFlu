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
import 'package:film_flu/presentation/notifiers/models/media_item_states.dart';
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

    final creditsMediaItemResponse = ref.read(getMediaCastProvider(
      CreditsMediaState(
          mediaType: widget.mediaTypeSelected,
          id: widget.mediaItemId,
          languageName: context.localizations.localeName),
    ));

    final reviewsMediaItemResponse = ref.read(getReviewsProvider(
      MediaItemState(
          mediaType: widget.mediaTypeSelected,
          id: widget.mediaItemId,
          languageName: context.localizations.localeName),
    ));

    final item = mediaItemResponse;
    final credits = creditsMediaItemResponse;
    final reviews = reviewsMediaItemResponse;

    return SingleChildScrollView(
      child: Column(
        children: [
          item.when(
              data: (mediaItem) => BackgroundImageMediaItem(
                    title: mediaItem.title ?? '',
                    isHomeScreen: false,
                    mediaItem: mediaItem.mediaItem!,
                  ),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => Shimmer(child: buildMediaDayWidget(context))),
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
                      Tab(text: context.localizations.information),
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
                        item.when(
                            data: (mediaItem) => ContainerTabMediaItem(
                                  child: InfoMedia(
                                    mediaItem: mediaItem.mediaItem,
                                    media: mediaItem.mediaList,
                                  ),
                                ),
                            error: (error, stackTrace) =>
                                Text(error.toString()),
                            loading: () =>
                                Shimmer(child: buildMediaDayWidget(context))),
                        reviews.when(
                            data: (reviews) {
                              return reviews.isEmpty
                                  ? Column(
                                      children: [
                                        Image.asset(
                                          AppAssets.emptyStateImage,
                                          fit: BoxFit.contain,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                        ),
                                        SizedBox(height: 20),
                                        Text(context
                                            .localizations.not_found_reviews),
                                      ],
                                    )
                                  : ContainerTabMediaItem(
                                      child: ListView.builder(
                                        itemCount: reviews.length,
                                        itemBuilder: (context, index) {
                                          ReviewEntity review = reviews[index];

                                          return ReviewsWidgetItem(
                                            review: review,
                                          );
                                        },
                                      ),
                                    );
                            },
                            error: (error, stackTrace) => Column(
                                  children: [
                                    Image.asset(
                                      AppAssets.emptyStateImage,
                                      fit: BoxFit.contain,
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                    ),
                                    SizedBox(height: 20),
                                    Text(context
                                        .localizations.not_found_reviews),
                                  ],
                                ),
                            loading: () =>
                                Shimmer(child: buildMediaDayWidget(context))),
                        credits.when(
                            data: (data) => ContainerTabMediaItem(
                                    child: MediaDataCast(
                                  cast: data.cast,
                                )),
                            error: (error, stackTrace) =>
                                Text(error.toString()),
                            loading: () =>
                                Shimmer(child: buildMediaDayWidget(context))),
                        credits.when(
                            data: (data) => ContainerTabMediaItem(
                                    child: MediaDataProduction(
                                  crew: data.crew,
                                )),
                            error: (error, stackTrace) =>
                                Text(error.toString()),
                            loading: () =>
                                Shimmer(child: buildMediaDayWidget(context)))
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
