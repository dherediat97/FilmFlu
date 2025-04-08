import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/presentation/features/common/network_image_widget.dart';
import 'package:film_flu/presentation/notifiers/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundImageMediaItem extends ConsumerStatefulWidget {
  const BackgroundImageMediaItem({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  ConsumerState<BackgroundImageMediaItem> createState() =>
      _BackgroundImageMediaItemState();
}

class _BackgroundImageMediaItemState
    extends ConsumerState<BackgroundImageMediaItem> {
  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appProvider);

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors:
              !appState.isDarkMode
                  ? [
                    AppColors.backgroundColorLight.withValues(alpha: 0.2),
                    AppColors.backgroundColorLight.withValues(alpha: 0.8),
                    AppColors.backgroundColorLight.withValues(alpha: 0.2),
                  ]
                  : [
                    AppColors.backgroundColorDark.withValues(alpha: 0.4),
                    AppColors.backgroundColorDark.withValues(alpha: 0.8),
                    AppColors.backgroundColorDark.withValues(alpha: 0.4),
                  ],
          stops: [0.1, 0.6, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstATop,
      child: Align(
        alignment: Alignment.topRight,
        child: NetworkImageWidget(
          imageUrl: widget.imageUrl!,
          errorWidget: SvgPicture.asset(AppAssets.noImageMovie),
          imageBuilder:
              (context, imageProvider) => Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
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
