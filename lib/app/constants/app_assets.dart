import 'package:film_flu/app/config/enviroment_config.dart';

class AppAssets {
  static const String assetsFolder =
      EnvironmentConfig.environment == 'prod' ? 'assets' : '';
  static const String imagesFolder = '$assetsFolder/images';
  static const String iconsFolder = '$assetsFolder/icons';

  static const String transparentLogo = '$imagesFolder/transparent_logo.png';
  static const String andalucianHeartIcon = '$iconsFolder/andalucian_heart.svg';
  static const String fullHeartIcon = '$iconsFolder/full_heart.svg';

  AppAssets._();
}
