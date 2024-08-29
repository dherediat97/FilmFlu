import 'package:flutter/material.dart';

class ContainerTabMediaItem<T> extends StatelessWidget {
  const ContainerTabMediaItem({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: child,
    );
  }
}
