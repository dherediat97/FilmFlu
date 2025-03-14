import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/data/enums/media_type.dart';
import 'package:film_flu/presentation/features/app_bar/my_app_bar.dart';
import 'package:film_flu/presentation/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScaffoldPage extends ConsumerStatefulWidget {
  const ScaffoldPage({
    super.key,
    required this.child,
    this.appBar,
    this.bottomBar,
    this.floatingActionButton,
    this.routeName = '/',
  });

  final Widget child;
  final PreferredSize? appBar;
  final Widget? bottomBar;
  final Widget? floatingActionButton;
  final String routeName;

  @override
  ConsumerState<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends ConsumerState<ScaffoldPage> {
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.floatingActionButton,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: TopAppBar(isMainMenu: true, mediaTypeSelected: MediaType.movie),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: ref.watch(homeProvider).index,
        elevation: 20,
        onTap: (int index) {
          if (_pageController.hasClients) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          }

          ref.watch(homeProvider.notifier).setMediaTypeSelected(switch (index) {
            0 => MediaType.movie,
            1 => MediaType.tv,
            _ => MediaType.search,
          });

          context.pushReplacement(AppRoutePaths.homeRoute);
        },
      ),
      body: widget.child,
    );
  }
}
