/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:lottie/lottie.dart';

class $FontsGen {
  const $FontsGen();

  /// File path: fonts/LilitaOne-Regular.ttf
  String get lilitaOneRegular => 'fonts/LilitaOne-Regular.ttf';

  /// File path: fonts/ShadowsIntoLight-Regular.ttf
  String get shadowsIntoLightRegular => 'fonts/ShadowsIntoLight-Regular.ttf';

  /// File path: fonts/YsabeauInfant-Bold.ttf
  String get ysabeauInfantBold => 'fonts/YsabeauInfant-Bold.ttf';

  /// File path: fonts/YsabeauInfant-Italic.ttf
  String get ysabeauInfantItalic => 'fonts/YsabeauInfant-Italic.ttf';

  /// File path: fonts/YsabeauInfant-Regular.ttf
  String get ysabeauInfantRegular => 'fonts/YsabeauInfant-Regular.ttf';

  /// List of all assets
  List<String> get values => [
        lilitaOneRegular,
        shadowsIntoLightRegular,
        ysabeauInfantBold,
        ysabeauInfantItalic,
        ysabeauInfantRegular
      ];
}

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/splash_animation.json
  LottieGenImage get splashAnimation =>
      const LottieGenImage('assets/animations/splash_animation.json');

  /// List of all assets
  List<LottieGenImage> get values => [splashAnimation];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/actor_icon.svg
  SvgGenImage get actorIcon => const SvgGenImage('assets/icons/actor_icon.svg');

  /// File path: assets/icons/actor_profile_not_found.svg
  SvgGenImage get actorProfileNotFound =>
      const SvgGenImage('assets/icons/actor_profile_not_found.svg');

  /// File path: assets/icons/actress_icon.svg
  SvgGenImage get actressIcon =>
      const SvgGenImage('assets/icons/actress_icon.svg');

  /// File path: assets/icons/anime_boy.svg
  SvgGenImage get animeBoy => const SvgGenImage('assets/icons/anime_boy.svg');

  /// File path: assets/icons/anime_girl.svg
  SvgGenImage get animeGirl => const SvgGenImage('assets/icons/anime_girl.svg');

  /// Directory path: assets/icons/flags
  $AssetsIconsFlagsGen get flags => const $AssetsIconsFlagsGen();

  /// File path: assets/icons/full_heart.svg
  SvgGenImage get fullHeart => const SvgGenImage('assets/icons/full_heart.svg');

  /// File path: assets/icons/placeholder_image.svg
  SvgGenImage get placeholderImage =>
      const SvgGenImage('assets/icons/placeholder_image.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        actorIcon,
        actorProfileNotFound,
        actressIcon,
        animeBoy,
        animeGirl,
        fullHeart,
        placeholderImage
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.png
  AssetGenImage get logoPng => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo.svg
  SvgGenImage get logoSvg => const SvgGenImage('assets/images/logo.svg');

  /// List of all assets
  List<dynamic> get values => [logoPng, logoSvg];
}

class $AssetsIconsFlagsGen {
  const $AssetsIconsFlagsGen();

  /// File path: assets/icons/flags/de_flag.svg
  SvgGenImage get deFlag => const SvgGenImage('assets/icons/flags/de_flag.svg');

  /// File path: assets/icons/flags/en_flag.svg
  SvgGenImage get enFlag => const SvgGenImage('assets/icons/flags/en_flag.svg');

  /// File path: assets/icons/flags/es_flag.svg
  SvgGenImage get esFlag => const SvgGenImage('assets/icons/flags/es_flag.svg');

  /// File path: assets/icons/flags/fi_flag.svg
  SvgGenImage get fiFlag => const SvgGenImage('assets/icons/flags/fi_flag.svg');

  /// File path: assets/icons/flags/fr_flag.svg
  SvgGenImage get frFlag => const SvgGenImage('assets/icons/flags/fr_flag.svg');

  /// File path: assets/icons/flags/hi_flag.svg
  SvgGenImage get hiFlag => const SvgGenImage('assets/icons/flags/hi_flag.svg');

  /// File path: assets/icons/flags/is_flag.svg
  SvgGenImage get isFlag => const SvgGenImage('assets/icons/flags/is_flag.svg');

  /// File path: assets/icons/flags/it_flag.svg
  SvgGenImage get itFlag => const SvgGenImage('assets/icons/flags/it_flag.svg');

  /// File path: assets/icons/flags/ja_flag.svg
  SvgGenImage get jaFlag => const SvgGenImage('assets/icons/flags/ja_flag.svg');

  /// File path: assets/icons/flags/nl_flag.svg
  SvgGenImage get nlFlag => const SvgGenImage('assets/icons/flags/nl_flag.svg');

  /// File path: assets/icons/flags/pt_flag.svg
  SvgGenImage get ptFlag => const SvgGenImage('assets/icons/flags/pt_flag.svg');

  /// File path: assets/icons/flags/sk_flag.svg
  SvgGenImage get skFlag => const SvgGenImage('assets/icons/flags/sk_flag.svg');

  /// File path: assets/icons/flags/sv_flag.svg
  SvgGenImage get svFlag => const SvgGenImage('assets/icons/flags/sv_flag.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        deFlag,
        enFlag,
        esFlag,
        fiFlag,
        frFlag,
        hiFlag,
        isFlag,
        itFlag,
        jaFlag,
        nlFlag,
        ptFlag,
        skFlag,
        svFlag
      ];
}

class Assets {
  Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $FontsGen fonts = $FontsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(
    this._assetName, {
    this.flavors = const {},
  });

  final String _assetName;
  final Set<String> flavors;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
