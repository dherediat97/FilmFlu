import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/container_tab_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_data_cast.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_data_production.dart';
import 'package:film_flu/presentation/features/media_details/widgets/reviews_widget_item.dart';
import 'package:film_flu/presentation/widgets/empty_state_widget.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
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
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaDetailBloc, MediaDetailState>(
      builder: (context, state) {
        MediaType mediaTypeSelected =
            context.read<HomeBloc>().state.mediaTypeSelected;

        return SingleChildScrollView(
          child: Column(
            children: [
              state.mediaItem != null
                  ? BackgroundImageMediaItem(
                      productionCompanyImage: state.productionCompanyImage,
                      isHomeScreen: false,
                      mediaItem: state.mediaItem,
                    )
                  : const PlaceholderLoader(),
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
                            text: mediaTypeSelected == MediaType.movie
                                ? context.localizations.about_movie
                                : context.localizations.about_serie,
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
                              child: state.mediaItem?.overview != null
                                  ? Text(
                                      state.mediaItem!.overview!,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )
                                  : const EmptyStateWidget(
                                      errorMessage:
                                          'No se ha encontrado descripción'),
                            ),
                            ContainerTabMediaItem(
                              child: state.reviews != null
                                  ? ListView.builder(
                                      itemCount: state.reviews?.length,
                                      itemBuilder: (context, index) {
                                        ReviewEntity? review =
                                            state.reviews?[index];

                                        return ReviewsWidgetItem(
                                          review: review,
                                        );
                                      },
                                    )
                                  : const PlaceholderLoader(),
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
