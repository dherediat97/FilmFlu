import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/presentation/features/app_bar/my_app_bar.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:film_flu/presentation/features/search/widgets/serie_filters.dart';
import 'package:film_flu/presentation/top_blocs/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({
    super.key,
    required this.child,
    this.appBar,
    this.bottomBar,
    this.floatingActionButton,
    this.fullScreenMode = false,
  });

  final Widget child;
  final PreferredSize? appBar;
  final Widget? bottomBar;
  final Widget? floatingActionButton;
  final bool fullScreenMode;

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
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
    context.read<AppBloc>().add(const AppEvent.changeStartLang());

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return current.uiState.isLoading();
      },
      builder: (context, state) {
        return Scaffold(
            appBar: !widget.fullScreenMode
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(70),
                    child: MyAppBar(
                      mediaTypeSelected: state.mediaTypeSelected,
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
                    currentIndex: _selectedIndex,
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
            body: _pageController.hasClients
                ? PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });

                      setState(() {
                        var category =
                            MediaType.values.elementAt(_selectedIndex);
                        context
                            .read<HomeBloc>()
                            .add(HomeEvent.switchCategory(category));
                      });
                    },
                    children: const [
                      MoviesListWidget(),
                      SeriesListWidget(),
                      SerieFiltersWidget(),
                    ],
                  )
                : widget.child);
      },
    );
  }
}
