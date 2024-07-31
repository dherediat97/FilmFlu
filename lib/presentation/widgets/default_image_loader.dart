import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class DefaultImageLoader extends StatefulWidget {
  const DefaultImageLoader({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  State<DefaultImageLoader> createState() => _DefaultImageLoaderState();
}

class _DefaultImageLoaderState extends State<DefaultImageLoader> {
  @override
  Widget build(BuildContext context) {
    var imageWidget = OctoImage(
      image: CachedNetworkImageProvider(
        widget.imageUrl!,
      ),
      fit: BoxFit.cover,
      progressIndicatorBuilder:
          OctoProgressIndicator.circularProgressIndicator(),
    );
    return widget.imageUrl != null ? imageWidget : const PlaceholderLoader();
  }
}
