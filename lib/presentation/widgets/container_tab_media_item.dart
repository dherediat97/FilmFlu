import 'package:film_flu/app/types/ui_state.dart';
import 'package:flutter/material.dart';

class ContainerTabMediaItem<T> extends StatelessWidget {
  const ContainerTabMediaItem({
    super.key,
    required this.state,
    required this.child,
  });

  final Widget child;
  final UiState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: child,
    );
  }
}
