import 'package:flutter/material.dart';

class DefaultImageLoader extends StatelessWidget {
  const DefaultImageLoader({
    super.key,
    required this.child,
    required this.progress,
  });

  final Widget child;
  final ImageChunkEvent? progress;

  @override
  Widget build(BuildContext context) {
    if (progress == null) return child;

    return Center(
      child: progress?.expectedTotalBytes == null
          ? const CircularProgressIndicator()
          : CircularProgressIndicator(
              value: progress!.cumulativeBytesLoaded /
                  progress!.expectedTotalBytes!,
            ),
    );
  }
}
