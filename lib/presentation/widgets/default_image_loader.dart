import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
import 'package:flutter/material.dart';

class DefaultImageWidget extends StatelessWidget {
  const DefaultImageWidget({
    super.key,
    required this.imageUrl,
    this.darkenImage = false,
  });

  final String? imageUrl;
  final bool darkenImage;

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            imageUrl: imageUrl!,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            progressIndicatorBuilder: (context, url, progress) =>
                const Center(child: PlaceholderLoader()),
            imageBuilder: (context, imageProvider) => darkenImage
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        opacity: darkenImage ? 0.6 : 1.0,
                      ),
                    ),
                  )
                : Container(),
          )
        : const PlaceholderLoader();
  }
}
