import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';
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
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        context
            .read<HomeBloc>()
            .add(const HomeEvent.switchCategory(MediaType.movie));
        context.pushReplacement(AppRoutePaths.moviesRoute);
        break;

      case 1:
        context
            .read<HomeBloc>()
            .add(const HomeEvent.switchCategory(MediaType.tv));
        context.pushReplacement(AppRoutePaths.seriesRoute);
        break;
      case 2:
        context.pushReplacement(AppRoutePaths.searchRoute);
        break;
    }
  }
}
