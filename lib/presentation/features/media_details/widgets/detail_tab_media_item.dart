import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/actor_worker_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/film_worker_item.dart';
import 'package:film_flu/presentation/widgets/container_tab_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/reviews_widget_item.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
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
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(
      () {
        var index = _tabController.index;
        switch (index) {
          case 0:
            break;
          case 1:
            context.read<MediaDetailBloc>().add(
                  MediaDetailEvent.getReviews(
                    widget.mediaItemType,
                    widget.mediaItemId,
                  ),
                );
            break;
          case 2:
          case 3:
            context.read<MediaDetailBloc>().add(
                  MediaDetailEvent.getCredits(
                    widget.mediaItemType,
                    widget.mediaItemId,
                  ),
                );
            break;
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
                        length: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TabBar(
                              controller: _tabController,
                              tabs: [
                                Tab(
                                  text: widget.mediaItemType ==
                                          MediaListConstants.movieMediaType
                                      ? context.localizations.about_movie
                                      : context.localizations.about_serie,
                                ),
                                Tab(text: context.localizations.reviews),
                                Tab(text: context.localizations.character_cast),
                                Tab(
                                    text:
                                        context.localizations.production_cast),
                              ],
                            ),
                            SizedBox(
                              height: 400,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  ContainerTabMediaItem(
                                    item: state.mediaItem!.overview,
                                    child: Text(
                                      state.mediaItem!.overview.toString(),
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  ContainerTabMediaItem(
                                      item: state.reviews,
                                      child: ListView.builder(
                                        itemCount: state.reviews?.length,
                                        itemBuilder: (context, index) {
                                          ReviewEntity? review =
                                              state.reviews?[index];

                                          return review != null
                                              ? ReviewsWidgetItem(
                                                  review: review,
                                                )
                                              : EmptyState();
                                        },
                                      )),
                                  state.credits?.cast != null
                                      ? ContainerTabMediaItem(
                                          item: state.credits,
                                          child: GridView.custom(
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 340,
                                            ),
                                            childrenDelegate:
                                                SliverChildBuilderDelegate(
                                              childCount:
                                                  state.credits!.cast.length,
                                              (_, index) {
                                                return FilmActorItem(
                                                  index: index,
                                                  cast: state.credits!.cast,
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  state.credits?.crew != null
                                      ? ContainerTabMediaItem(
                                          item: state.credits,
                                          child: GridView.custom(
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 340,
                                            ),
                                            childrenDelegate:
                                                SliverChildBuilderDelegate(
                                              childCount:
                                                  state.credits!.crew.length,
                                              (_, index) {
                                                return FilmWorkerItem(
                                                  index: index,
                                                  crew: state.credits!.crew,
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : Container(),
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
