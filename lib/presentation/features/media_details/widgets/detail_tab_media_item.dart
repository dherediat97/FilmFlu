import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/container_tab_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/info_media.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_data_cast.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_data_production.dart';
import 'package:film_flu/presentation/features/media_details/widgets/reviews_widget_item.dart';
import 'package:film_flu/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailTabMediaItem extends StatefulWidget {
  const DetailTabMediaItem({
    super.key,
    required this.mediaTypeSelected,
    required this.mediaItemId,
  });

  final MediaType mediaTypeSelected;
  final int mediaItemId;

  @override
  State<DetailTabMediaItem> createState() => _DetailTabMediaItem();
}

class _DetailTabMediaItem extends State<DetailTabMediaItem>
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
          context.read<MediaDetailBloc>().add(MediaDetailEvent.getMedia(
                widget.mediaTypeSelected,
                widget.mediaItemId,
              ));
          break;
        case 1:
          context.read<MediaDetailBloc>().add(MediaDetailEvent.getReviews(
                widget.mediaTypeSelected,
                widget.mediaItemId,
              ));
          break;
        case 2:
          context.read<MediaDetailBloc>().add(MediaDetailEvent.getCredits(
                widget.mediaTypeSelected,
                widget.mediaItemId,
                true,
              ));
          break;
        case 3:
          context.read<MediaDetailBloc>().add(MediaDetailEvent.getCredits(
                widget.mediaTypeSelected,
                widget.mediaItemId,
                false,
              ));
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
    return BlocBuilder<MediaDetailBloc, MediaDetailState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ShimmerLoading(
                isLoading: state.mediaItem == null,
                child: BackgroundImageMediaItem(
                  productionCompanyImage: state.productionCompanyImage,
                  isHomeScreen: false,
                  mediaItem: state.mediaItem,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
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
                            ContainerTabMediaItem(
                              child: ShimmerLoading(
                                isLoading: state.reviews == null,
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
                            ContainerTabMediaItem(
                              child: MediaDataCast(cast: state.cast),
                            ),
                            ContainerTabMediaItem(
                              child: MediaDataProduction(crew: state.crew),
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
      },
    );
  }
}
