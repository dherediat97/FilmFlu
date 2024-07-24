import 'package:flutter/material.dart';

class ContainerTabMediaItem extends StatelessWidget {
  const ContainerTabMediaItem({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: child,
    );
  }
}
