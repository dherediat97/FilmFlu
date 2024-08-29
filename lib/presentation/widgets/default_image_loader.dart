import 'package:cached_network_image/cached_network_image.dart';
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
      cacheKey: imageUrl,
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
        ),
      ),
    );
  }
}
