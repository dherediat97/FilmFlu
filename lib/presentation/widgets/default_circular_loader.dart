import 'package:flutter/material.dart';

class DefaultCircularLoader extends StatelessWidget {
  const DefaultCircularLoader({
    super.key,
    required this.child,
    required this.loadingProgress,
  });

  final Widget child;
  final ImageChunkEvent? loadingProgress;

  @override
  Widget build(BuildContext context) {
    if (loadingProgress == null) return child;

    return Center(
      child: loadingProgress?.expectedTotalBytes == null
          ? const CircularProgressIndicator()
          : CircularProgressIndicator(
              value: loadingProgress!.cumulativeBytesLoaded /
                  loadingProgress!.expectedTotalBytes!,
            ),
    );
  }
}
