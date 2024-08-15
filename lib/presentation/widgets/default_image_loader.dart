import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
import 'package:flutter/material.dart';

class DefaultImageWidget extends StatelessWidget {
  const DefaultImageWidget({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.cover,
      cacheKey: imageUrl,
      errorWidget: (context, url, error) => const Icon(Icons.error),
      progressIndicatorBuilder: (context, url, progress) =>
          const Center(child: PlaceholderLoader()),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
      ),
    );
  }
}
