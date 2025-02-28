import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/presentation/features/app_bar/my_app_bar.dart';
import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:film_flu/presentation/features/search/widgets/serie_filters.dart';
import 'package:film_flu/presentation/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldPage extends ConsumerStatefulWidget {
  const ScaffoldPage({
    super.key,
    required this.child,
    this.appBar,
    this.bottomBar,
    this.floatingActionButton,
    this.fullScreenMode = false,
    this.routeName = '/',
  });

  final Widget child;
  final PreferredSize? appBar;
  final Widget? bottomBar;
  final Widget? floatingActionButton;
  final bool fullScreenMode;
  final String routeName;

  @override
  ConsumerState<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends ConsumerState<ScaffoldPage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _selectedIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final homeState = ref.read(homeProvider(MediaType.movie));

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: widget.floatingActionButton,
        appBar: !widget.fullScreenMode
            ? PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: TopAppBar(
                  mainMenu: true,
                  mediaTypeSelected: MediaType.movie,
                ))
            : null,
        bottomNavigationBar: !widget.fullScreenMode
            ? BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.local_movies),
                    label: context.localizations.movies,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.live_tv),
                    label: context.localizations.series,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.search),
                    label: context.localizations.search,
                  ),
                ],
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerLowest,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                currentIndex: _selectedIndex,
                elevation: 20,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });

                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              )
            : null,
        body: widget.routeName.contains(AppRoutePaths.homeRoute)
            ? PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;

                    var category = MediaType.values.elementAt(_selectedIndex);
                    ref.read(homeProvider(category));
                  });
                },
                children: const [
                  MoviesListWidget(),
                  SeriesListWidget(),
                  SerieFiltersWidget(),
                ],
              )
            : widget.child);
  }
}
