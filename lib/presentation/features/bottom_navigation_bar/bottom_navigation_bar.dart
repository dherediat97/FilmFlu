import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/domain/enums/media_types.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      currentIndex: ref.watch(homeProvider).index,
      elevation: 20,
      onTap: (int index) {
        ref.watch(homeProvider.notifier).setMediaTypeSelected(switch (index) {
          0 => MediaType.movie,
          1 => MediaType.tv,
          2 => MediaType.person,
          _ => MediaType.movie,
        });

        switch (index) {
          case 0:
            HomeScreenRoute(mediaTypeSelected: MediaType.movie).go(context);
            break;
          case 1:
            HomeScreenRoute(mediaTypeSelected: MediaType.tv).go(context);
            break;
          case 2:
            HomeScreenRoute(mediaTypeSelected: MediaType.person).go(context);
          default:
            HomeScreenRoute(mediaTypeSelected: MediaType.movie).go(context);
            break;
        }
      },
    );
  }
}
