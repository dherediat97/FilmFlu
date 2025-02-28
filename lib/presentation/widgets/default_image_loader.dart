import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultImageWidget extends StatelessWidget {
  const DefaultImageWidget({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: <Color>[
            Colors.transparent,
            Colors.black.withOpacity(0.8),
            Colors.transparent,
          ],
          stops: [0.1, 0.6, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstATop,
      child: Align(
        alignment: Alignment.topRight,
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          cacheKey: imageUrl,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          errorWidget: (context, url, error) =>
              SvgPicture.asset(AppAssets.noImageMovie),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
