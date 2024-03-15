/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

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
  String get splashAnimation => 'assets/animations/splash_animation.json';

  /// List of all assets
  List<String> get values => [splashAnimation];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/actor_icon.svg
  String get actorIcon => 'assets/icons/actor_icon.svg';

  /// File path: assets/icons/actor_profile_not_found.svg
  String get actorProfileNotFound => 'assets/icons/actor_profile_not_found.svg';

  /// File path: assets/icons/actress_icon.svg
  String get actressIcon => 'assets/icons/actress_icon.svg';

  /// File path: assets/icons/anime_boy.svg
  String get animeBoy => 'assets/icons/anime_boy.svg';

  /// File path: assets/icons/anime_girl.svg
  String get animeGirl => 'assets/icons/anime_girl.svg';

  $AssetsIconsFlagsGen get flags => const $AssetsIconsFlagsGen();

  /// File path: assets/icons/placeholder_image.svg
  String get placeholderImage => 'assets/icons/placeholder_image.svg';

  /// List of all assets
  List<String> get values => [
        actorIcon,
        actorProfileNotFound,
        actressIcon,
        animeBoy,
        animeGirl,
        placeholderImage
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.jpg
  AssetGenImage get logoJpg => const AssetGenImage('assets/images/logo.jpg');

  /// File path: assets/images/logo.png
  AssetGenImage get logoPng => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/transparent_logo.png
  AssetGenImage get transparentLogo =>
      const AssetGenImage('assets/images/transparent_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [logoJpg, logoPng, transparentLogo];
}

class $AssetsIconsFlagsGen {
  const $AssetsIconsFlagsGen();

  /// File path: assets/icons/flags/bs_flag.svg
  String get bsFlag => 'assets/icons/flags/bs_flag.svg';

  /// File path: assets/icons/flags/de_flag.svg
  String get deFlag => 'assets/icons/flags/de_flag.svg';

  /// File path: assets/icons/flags/el_flag.svg
  String get elFlag => 'assets/icons/flags/el_flag.svg';

  /// File path: assets/icons/flags/en_flag.svg
  String get enFlag => 'assets/icons/flags/en_flag.svg';

  /// File path: assets/icons/flags/es_cr_flag.svg
  String get esCrFlag => 'assets/icons/flags/es_cr_flag.svg';

  /// File path: assets/icons/flags/es_flag.svg
  String get esFlag => 'assets/icons/flags/es_flag.svg';

  /// File path: assets/icons/flags/es_pr.svg
  String get esPr => 'assets/icons/flags/es_pr.svg';

  /// File path: assets/icons/flags/fi_flag.svg
  String get fiFlag => 'assets/icons/flags/fi_flag.svg';

  /// File path: assets/icons/flags/fr_flag.svg
  String get frFlag => 'assets/icons/flags/fr_flag.svg';

  /// File path: assets/icons/flags/hi_flag.svg
  String get hiFlag => 'assets/icons/flags/hi_flag.svg';

  /// File path: assets/icons/flags/hy_flag.svg
  String get hyFlag => 'assets/icons/flags/hy_flag.svg';

  /// File path: assets/icons/flags/is_flag.svg
  String get isFlag => 'assets/icons/flags/is_flag.svg';

  /// File path: assets/icons/flags/it_flag.svg
  String get itFlag => 'assets/icons/flags/it_flag.svg';

  /// File path: assets/icons/flags/ja_flag.svg
  String get jaFlag => 'assets/icons/flags/ja_flag.svg';

  /// File path: assets/icons/flags/nl_flag.svg
  String get nlFlag => 'assets/icons/flags/nl_flag.svg';

  /// File path: assets/icons/flags/pt_st.svg
  String get ptSt => 'assets/icons/flags/pt_st.svg';

  /// File path: assets/icons/flags/sk_flag.svg
  String get skFlag => 'assets/icons/flags/sk_flag.svg';

  /// File path: assets/icons/flags/sv_flag.svg
  String get svFlag => 'assets/icons/flags/sv_flag.svg';

  /// File path: assets/icons/flags/vi_flag.svg
  String get viFlag => 'assets/icons/flags/vi_flag.svg';

  /// List of all assets
  List<String> get values => [
        bsFlag,
        deFlag,
        elFlag,
        enFlag,
        esCrFlag,
        esFlag,
        esPr,
        fiFlag,
        frFlag,
        hiFlag,
        hyFlag,
        isFlag,
        itFlag,
        jaFlag,
        nlFlag,
        ptSt,
        skFlag,
        svFlag,
        viFlag
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
  const AssetGenImage(this._assetName);

  final String _assetName;

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
