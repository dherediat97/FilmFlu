import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageWidget extends StatefulWidget {
  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    required this.errorWidget,
    this.imageBuilder,
  });
  final String imageUrl;
  final ImageWidgetBuilder? imageBuilder;
  final Widget errorWidget;

  @override
  State<NetworkImageWidget> createState() => _NetworkImageWidgetState();
}

class _NetworkImageWidgetState extends State<NetworkImageWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      key: widget.key,
      imageBuilder: widget.imageBuilder,
      cacheKey: widget.imageUrl,
      progressIndicatorBuilder:
          (context, url, progress) => Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: SizedBox(height: 200, width: 300),
          ),
      errorWidget: (context, url, error) => widget.errorWidget,
    );
  }
}
