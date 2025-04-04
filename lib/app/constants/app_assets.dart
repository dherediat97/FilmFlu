import 'package:film_flu/app/config/enviroment_config.dart';

class AppAssets {
  static const String assetsFolder =
      EnvironmentConfig.environment == 'prod' ? 'assets' : '';

  static const String imagesFolder = '$assetsFolder/images';
  static const String iconsFolder = '$assetsFolder/icons';
  static const String flagsFolder = '$assetsFolder/flags';

  static const String logoSvgIcon = '$imagesFolder/logo.svg';
  static const String logoIcon = '$imagesFolder/logo.png';
  static const String emptyStateImage = '$imagesFolder/empty_state.jpg';
  static const String noImageMovie = '$imagesFolder/movie_not_found.svg';
  static const String noImagePerson = '$imagesFolder/profile_not_found.svg';

  static const String actorImageIcon = '$iconsFolder/actor_icon.svg';
  static const String actressImageIcon = '$iconsFolder/actress_icon.svg';
  static const String productionPersonMale =
      '$iconsFolder/production_person_male.png';
  static const String productionPersonFemale =
      '$iconsFolder/production_person_female.png';
  static const String animeActorImageIcon = '$iconsFolder/anime_boy.svg';
  static const String animeActressImageIcon = '$iconsFolder/anime_girl.svg';
  static const String andalucianHeartIcon = '$iconsFolder/andalucian_heart.svg';
  static const String fullHeartIcon = '$iconsFolder/full_heart.svg';
  static const String githubIcon = '$iconsFolder/github_icon.svg';

  AppAssets._();
}
