import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_cast_list.dart';
import 'package:film_flu/presentation/features/media_details/widgets/sliver_app_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditsWidget extends StatefulWidget {
  const CreditsWidget({
    super.key,
  });

  @override
  State<CreditsWidget> createState() => _CreditsWidget();
}

class _CreditsWidget extends State<CreditsWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaDetailBloc, MediaDetailState>(
      builder: (context, state) {
        int lengthCast =
            state.mediaItem?.credits?.cast.isNotEmpty == true ? 1 : 0;
        int lengthCrew =
            state.mediaItem?.credits?.crew.isNotEmpty == true ? 1 : 0;

        return state.mediaItem != null
            ? lengthCrew + lengthCast != 0
                ? DefaultTabController(
                    length: lengthCast + lengthCrew,
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            expandedHeight: 800,
                            pinned: false,
                            floating: false,
                            snap: false,
                            toolbarHeight: 0,
                            flexibleSpace: FlexibleSpaceBar(
                              background: BackgroundImageMediaItem(
                                mediaItem: state.mediaItem,
                                movieName: state.movieName,
                              ),
                            ),
                          ),
                          SliverPersistentHeader(
                            floating: true,
                            delegate: SliverAppBarDelegate(
                              TabBar(controller: _tabController, tabs: [
                                if (lengthCast != 0)
                                  Tab(
                                    icon: const Icon(Icons.movie),
                                    text: context.localizations.character_cast,
                                  ),
                                if (lengthCrew != 0)
                                  Tab(
                                    icon: const Icon(Icons.movie),
                                    text: context.localizations.production_cast,
                                  )
                              ]),
                            ),
                          ),
                        ];
                      },
                      body: lengthCrew + lengthCast != 0
                          ? TabBarView(
                              controller: _tabController,
                              children: [
                                if (lengthCast != 0)
                                  FilmCast(
                                    genres: state.mediaItem!.genres,
                                    movieId: state.mediaItem!.id.toString(),
                                    isCast: true,
                                    mediaType: AppConstants.mediaType,
                                    cast: state.mediaItem!.credits!.cast,
                                    crew: state.mediaItem!.credits!.crew,
                                  ),
                                if (lengthCrew != 0)
                                  FilmCast(
                                    genres: state.mediaItem!.genres,
                                    movieId: state.mediaItem!.id.toString(),
                                    isCast: false,
                                    mediaType: AppConstants.mediaType,
                                    cast: state.mediaItem!.credits!.cast,
                                    crew: state.mediaItem!.credits!.crew,
                                  )
                              ],
                            )
                          : Container(),
                    ),
                  )
                : BackgroundImageMediaItem(
                    mediaItem: state.mediaItem,
                    movieName: state.movieName,
                  )
            : Container();
      },
    );
  }
}
