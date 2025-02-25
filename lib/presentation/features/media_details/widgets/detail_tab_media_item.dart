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
          ref.read(mediaItemDetailProvider(MediaItemState(
            mediaType: widget.mediaTypeSelected,
            id: widget.mediaItemId,
            languageName: context.localizations.localeName,
          )));
          break;
        case 1:
          ref.read(fetchReviewsProvider(MediaItemState(
            mediaType: widget.mediaTypeSelected,
            id: widget.mediaItemId,
            languageName: context.localizations.localeName,
          )));
          break;
        case 2:
          ref.read(mediaCreditsProvider(CreditsMediaState(
            mediaType: widget.mediaTypeSelected,
            id: widget.mediaItemId,
            languageName: context.localizations.localeName,
            isCast: true,
          )));
          break;
        case 3:
          ref.read(mediaCreditsProvider(CreditsMediaState(
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
    final state = ref.read(mediaItemDetailProvider(MediaItemState(
      mediaType: widget.mediaTypeSelected,
      id: widget.mediaItemId,
      languageName: context.localizations.localeName,
    )));

    return mediaDetailWidget(state);
  }

  mediaDetailWidget(AsyncValue<MediaItemDetailState?> state) {
    final item = state.value;

    return SingleChildScrollView(
      child: Column(
        children: [
          item?.mediaItem == null
              ? Shimmer(child: buildMediaDayWidget(context))
              : BackgroundImageMediaItem(
                  title: item?.mediaItem.title ?? '',
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
                        Shimmer(
                          child: item?.reviews == null
                              ? buildMediaDayWidget(context)
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
                        ),
                        Shimmer(
                          child: item?.cast == null
                              ? buildMediaDayWidget(context)
                              : ContainerTabMediaItem(
                                  child: MediaDataCast(cast: item?.cast ?? []),
                                ),
                        ),
                        Shimmer(
                          child: item?.crew == null
                              ? buildMediaDayWidget(context)
                              : ContainerTabMediaItem(
                                  child: MediaDataProduction(
                                      crew: item?.crew ?? []),
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
