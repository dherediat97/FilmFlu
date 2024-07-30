import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
import 'package:flutter/material.dart';

class ContainerTabMediaItem<T> extends StatelessWidget {
  const ContainerTabMediaItem({
    super.key,
    required this.state,
    required this.item,
    required this.child,
  });

  final Widget child;
  final UiState state;
  final T item;

  @override
  Widget build(BuildContext context) {
    if (item == null || state.isLoading()) {
      return PlaceholderLoader(child: child);
    } else {
      return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: child,
      );
    }
  }
}
