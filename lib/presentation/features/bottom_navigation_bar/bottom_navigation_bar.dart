import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/presentation/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);

    return BottomNavigationBar(
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
          icon: const Icon(Icons.person),
          label: context.localizations.artists,
        ),
      ],
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.white,
      elevation: 20,
      currentIndex: state,
      onTap: (int index) {
        ref.read(homeProvider.notifier).setMediaTypeSelected(index);

        switch (index) {
          case 0:
            MovieScreenRoute().push(context);
            break;
          case 1:
            TVSeriesScreenRoute().push(context);
            break;
          case 2:
            TrendingPersonScreenRoute().push(context);
          default:
            MovieScreenRoute().push(context);
            break;
        }
      },
    );
  }
}
