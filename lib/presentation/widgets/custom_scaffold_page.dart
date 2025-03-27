import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/presentation/features/app_bar/my_app_bar.dart';
import 'package:film_flu/presentation/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldPage extends ConsumerStatefulWidget {
  const ScaffoldPage({
    super.key,
    required this.child,
    this.floatingActionButton,
  });

  final Widget child;
  final Widget? floatingActionButton;

  @override
  ConsumerState<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends ConsumerState<ScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      appBar: TopAppBar(),
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
        },
      ),
      body: widget.child,
    );
  }
}
