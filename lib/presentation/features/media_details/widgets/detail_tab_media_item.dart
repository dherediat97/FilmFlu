import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/container_tab_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_data_cast.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_data_production.dart';
import 'package:film_flu/presentation/features/media_details/widgets/reviews_widget_item.dart';
import 'package:film_flu/presentation/features/media_list/similars_list.dart';
import 'package:film_flu/presentation/notifiers/media_detail_notifier.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:film_flu/presentation/notifiers/models/media_item_states.dart';
import 'package:film_flu/presentation/view_models/similar_list_view_model.dart';
import 'package:film_flu/presentation/features/common/empty_state_widget.dart';
import 'package:film_flu/presentation/features/common/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailTabMediaItem extends ConsumerStatefulWidget {
  const DetailTabMediaItem({
    super.key,
    required this.mediaTypeSelected,
    required this.mediaItemId,
  });

  final String mediaTypeSelected;
  final int mediaItemId;

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
    final mediaItemResponse = ref.watch(
      getMediaItemDetailProvider(
        MediaItemState(
          mediaType: widget.mediaTypeSelected,
          id: widget.mediaItemId,
          languageName: context.localizations.localeName,
        ),
      ),
    );

    final creditsMediaItemResponse = ref.watch(
      getMediaCastProvider(
        CreditsMediaState(
          mediaType: widget.mediaTypeSelected,
          id: widget.mediaItemId,
          languageName: context.localizations.localeName,
        ),
      ),
    );

    final reviewsMediaItemResponse = ref.watch(
      getReviewsProvider(
        MediaItemState(
          mediaType: widget.mediaTypeSelected,
          id: widget.mediaItemId,
          languageName: context.localizations.localeName,
        ),
      ),
    );

    final similarsMediaItemResponse = ref.watch(
      similarListViewModelProvider(
        SimilarMediaFilter(
          mediaTypeSelected: widget.mediaTypeSelected,
          mediaTypeId: widget.mediaItemId,
          languageId: context.localizations.localeName,
        ),
      ),
    );

    final item = mediaItemResponse;
    final credits = creditsMediaItemResponse;
    final reviews = reviewsMediaItemResponse;
    final similars = similarsMediaItemResponse;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          item.when(
            data:
                (data) => BackgroundMediaItem(
                  title: data.title ?? '',
                  isHomeScreen: false,
                  mediaItem: data.mediaItem!,
                ),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => Shimmer(child: buildMediaDayWidget(context)),
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
                      Tab(text: context.localizations.information),
                      Tab(text: context.localizations.reviews),
                      Tab(text: context.localizations.character_cast),
                      Tab(text: context.localizations.production_cast),
                    ],
                  ),
                  SizedBox(
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          Column(
                            spacing: 24,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              item.when(
                                data:
                                    (data) =>
                                        data.mediaItem?.overview != null
                                            ? Text(
                                              data.mediaItem!.overview!,
                                              textAlign: TextAlign.start,
                                            )
                                            : Container(),
                                error:
                                    (error, stackTrace) =>
                                        Text(error.toString()),
                                loading: () => Shimmer(child: buildText(true)),
                              ),
                              similars.when(
                                data: (data) {
                                  if (data.isEmpty) return Container();

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        context.localizations.similars,
                                        maxFontSize: 30,
                                        minFontSize: 20,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge!.copyWith(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                        ),
                                      ),
                                      SimilarsList(
                                        mediaType: widget.mediaTypeSelected,
                                        mediaTypeId: widget.mediaItemId,
                                      ),
                                    ],
                                  );
                                },
                                error:
                                    (error, stackTrace) =>
                                        Text(error.toString()),
                                loading:
                                    () => Shimmer(
                                      child: buildMediaDayWidget(context),
                                    ),
                              ),
                            ],
                          ),
                          reviews.when(
                            data: (reviews) {
                              return reviews.isEmpty
                                  ? EmptyStateWidget(
                                    errorMessage:
                                        context.localizations.not_found_reviews,
                                    urlImage: AppAssets.emptyStateImage,
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
                            error:
                                (error, stackTrace) => EmptyStateWidget(
                                  errorMessage:
                                      context.localizations.not_found_reviews,
                                  urlImage: AppAssets.emptyStateImage,
                                ),
                            loading:
                                () => Shimmer(
                                  child: buildMediaDayWidget(context),
                                ),
                          ),
                          credits.when(
                            data:
                                (data) => ContainerTabMediaItem(
                                  child: MediaDataCast(cast: data.cast),
                                ),
                            error:
                                (error, stackTrace) => Text(error.toString()),
                            loading:
                                () => Shimmer(
                                  child: buildMediaDayWidget(context),
                                ),
                          ),
                          credits.when(
                            data:
                                (data) => ContainerTabMediaItem(
                                  child: MediaDataProduction(crew: data.crew),
                                ),
                            error:
                                (error, stackTrace) => Text(error.toString()),
                            loading:
                                () => Shimmer(
                                  child: buildMediaDayWidget(context),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
