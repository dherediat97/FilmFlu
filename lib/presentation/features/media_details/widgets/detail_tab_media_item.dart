import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/container_tab_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/info_media.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_data_cast.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_data_production.dart';
import 'package:film_flu/presentation/features/media_details/widgets/reviews_widget_item.dart';
import 'package:film_flu/presentation/notifiers/media_credits_notifier.dart';
import 'package:film_flu/presentation/notifiers/media_detail_notifier.dart';
import 'package:film_flu/presentation/notifiers/media_notifier.dart';
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
          ref.read(fetchMediaItemProvider(MediaItemState(
            mediaType: widget.mediaTypeSelected,
            id: widget.mediaItemId,
          )));

          break;
        case 1:
          ref.read(fetchReviewsProvider(MediaItemState(
            mediaType: widget.mediaTypeSelected,
            id: widget.mediaItemId,
          )));
          break;
        case 2:
          ref.read(mediaCreditsProvider(CreditsMediaState(
            mediaType: widget.mediaTypeSelected,
            id: widget.mediaItemId,
            isCast: true,
          )));
          break;
        case 3:
          ref.read(mediaCreditsProvider(CreditsMediaState(
            mediaType: widget.mediaTypeSelected,
            id: widget.mediaItemId,
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
    final state = ref
        .read(fetchMediaItemProvider(MediaItemState(
          mediaType: widget.mediaTypeSelected,
          id: widget.mediaItemId,
        )))
        .requireValue;

    return SingleChildScrollView(
      child: Column(
        children: [
          Shimmer(
            child: state.mediaItem == null
                ? buildMediaDayWidget(context)
                : BackgroundImageMediaItem(
                    title: state.mediaItem?.title ?? '',
                    productionCompanyImage: state.productionCompanyImage ?? '',
                    isHomeScreen: false,
                    mediaItem: state.mediaItem,
                  ),
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
                            mediaItem: state.mediaItem,
                            media: state.mediaList,
                          ),
                        ),
                        Shimmer(
                          child: state.reviews == null
                              ? buildMediaDayWidget(context)
                              : ContainerTabMediaItem(
                                  child: ListView.builder(
                                    itemCount: state.reviews?.length,
                                    itemBuilder: (context, index) {
                                      ReviewEntity? review =
                                          state.reviews?[index];

                                      return ReviewsWidgetItem(
                                        review: review,
                                      );
                                    },
                                  ),
                                ),
                        ),
                        Shimmer(
                          child: state.cast == null
                              ? buildMediaDayWidget(context)
                              : ContainerTabMediaItem(
                                  child: MediaDataCast(cast: state.cast ?? []),
                                ),
                        ),
                        Shimmer(
                          child: state.crew == null
                              ? buildMediaDayWidget(context)
                              : ContainerTabMediaItem(
                                  child: MediaDataProduction(
                                      crew: state.crew ?? []),
                                ),
                        )
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
