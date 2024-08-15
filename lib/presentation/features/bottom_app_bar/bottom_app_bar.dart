import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.movie),
          label: context.localizations.movies,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.movie),
          label: context.localizations.series,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search),
          label: context.localizations.search,
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onOptionSelected,
    );
  }

  void _onOptionSelected(int index) {
    _selectedIndex = index;

    switch (index) {
      case 0:
        context
            .read<HomeBloc>()
            .add(const HomeEvent.switchCategory(MediaType.movie));
        context.go(AppRoutePaths.moviesRoute);
        break;

      case 1:
        context
            .read<HomeBloc>()
            .add(const HomeEvent.switchCategory(MediaType.tv));
        context.go(AppRoutePaths.seriesRoute);
        break;

      case 2:
        context
            .read<HomeBloc>()
            .add(const HomeEvent.switchCategory(MediaType.search));
        context.go(AppRoutePaths.searchRoute);
        break;
    }
  }
}
