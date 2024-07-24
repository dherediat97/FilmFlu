import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/actor_worker_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/container_tab_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/reviews_widget_item.dart';
import 'package:film_flu/presentation/widgets/default_circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditsWidget extends StatefulWidget {
  const CreditsWidget({
    super.key,
    required this.mediaItemType,
    required this.mediaItemId,
  });

  final String mediaItemType;
  final int mediaItemId;

  @override
  State<CreditsWidget> createState() => _CreditsWidget();
}

class _CreditsWidget extends State<CreditsWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(
      () {
        var index = _tabController.index;
        switch (index) {
          case 0:
            break;
          case 1:
            context.read<MediaDetailBloc>().add(MediaDetailEvent.getReviews(
                widget.mediaItemType, widget.mediaItemId));
          case 2:
            context.read<MediaDetailBloc>().add(MediaDetailEvent.getCredits(
                widget.mediaItemType, widget.mediaItemId));
          default:
        }
      },
    );
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
        return state.mediaItem != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    BackgroundImageMediaItem(
                      mediaItem: state.mediaItem,
                      movieName: state.movieName,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TabBar(
                              controller: _tabController,
                              tabs: [
                                const Tab(text: 'Sobre la película'),
                                const Tab(text: 'Reseñas'),
                                Tab(text: context.localizations.character_cast),
                              ],
                            ),
                            SizedBox(
                              height: 400,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  ContainerTabMediaItem(
                                    child: Text(
                                      state.mediaItem!.overview.toString(),
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  ContainerTabMediaItem(
                                      child: state.reviews != null
                                          ? ListView.builder(
                                              itemCount: state.reviews?.length,
                                              itemBuilder: (context, index) {
                                                ReviewEntity review =
                                                    state.reviews![index];

                                                return ReviewsWidgetItem(
                                                  review: review,
                                                );
                                              },
                                            )
                                          : const DefaultCircularLoader()),
                                  ContainerTabMediaItem(
                                      child: state.credits != null
                                          ? ListView.builder(
                                              itemCount:
                                                  state.credits?.cast.length,
                                              itemBuilder: (context, index) {
                                                List<ActorEntity> cast =
                                                    state.credits!.cast;

                                                return FilmActorItem(
                                                  index: index,
                                                  cast: cast,
                                                );
                                              },
                                            )
                                          : const DefaultCircularLoader()),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
