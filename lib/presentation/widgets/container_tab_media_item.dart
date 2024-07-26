import 'package:film_flu/presentation/widgets/default_circular_loader.dart';
import 'package:flutter/material.dart';

class ContainerTabMediaItem<T> extends StatelessWidget {
  const ContainerTabMediaItem({
    super.key,
    required this.item,
    required this.child,
  });

  final Widget child;
  final T item;

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return const DefaultCircularLoader();
    } else {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: child,
      );
    }
  }
}
