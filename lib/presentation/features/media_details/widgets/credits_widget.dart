import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_cast_list.dart';
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
            ? SafeArea(
                child: lengthCrew + lengthCast != 0
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
                                    background: Column(children: [
                                  Container(
                                    height: 800,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.6),
                                          BlendMode.darken,
                                        ),
                                        image: Image.network(
                                          '${AppUrls.movieLandscapeBaseUrl}${state.mediaItem?.backdropPath}',
                                          fit: BoxFit.cover,
                                        ).image,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5,
                                                child: AutoSizeText(
                                                  state.movieName,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 32,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (state.mediaItem?.overview !=
                                                      null &&
                                                  state.mediaItem!.overview!
                                                      .isNotEmpty) ...[
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    context
                                                        .localizations.synopsis,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 40,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  alignment: Alignment.topLeft,
                                                  child: AutoSizeText(
                                                    state.mediaItem!.overview!,
                                                    maxLines: 20,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ])),
                              ),
                              SliverPersistentHeader(
                                floating: true,
                                delegate: _SliverAppBarDelegate(
                                  TabBar(
                                      controller: _tabController,
                                      unselectedLabelColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      labelColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      indicatorColor:
                                          Theme.of(context).colorScheme.primary,
                                      dividerColor: Colors.transparent,
                                      tabs: [
                                        if (lengthCast != 0)
                                          Tab(
                                            icon: const Icon(Icons.movie),
                                            text: context
                                                .localizations.character_cast,
                                          ),
                                        if (lengthCrew != 0)
                                          Tab(
                                            icon: const Icon(Icons.movie),
                                            text: context
                                                .localizations.production_cast,
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
                    : Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height - 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.darken,
                                ),
                                image: Image.network(
                                  '${AppUrls.movieLandscapeBaseUrl}${state.mediaItem?.backdropPath}',
                                  fit: BoxFit.cover,
                                ).image,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: AutoSizeText(
                                          state.movieName,
                                          maxLines: 3,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 32,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (state.mediaItem?.overview != null &&
                                          state.mediaItem!.overview!
                                              .isNotEmpty) ...[
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            context.localizations.synopsis,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          alignment: Alignment.topLeft,
                                          child: AutoSizeText(
                                            state.mediaItem!.overview!,
                                            maxLines: 20,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        )
                                      ],
                                    ],
                                  ),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
