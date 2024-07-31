import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
import 'package:flutter/material.dart';

class DefaultImageLoader extends StatelessWidget {
  const DefaultImageLoader({
    super.key,
    required this.imageUrl,
    this.darkenImage = false,
  });

  final String? imageUrl;
  final bool? darkenImage;

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            imageUrl: imageUrl!,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            progressIndicatorBuilder: (context, url, progress) =>
                const Center(child: PlaceholderLoader()),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Colors.white60, BlendMode.darken)),
              ),
            ),
          )
        : const PlaceholderLoader();
  }
}
