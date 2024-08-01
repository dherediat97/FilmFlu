import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';

class AppRoutePaths {
  static String startRoute = '/';

  static String homeRoute = '/main/${MediaListConstants.movieMediaType}';
  static String homeControllerRoute = '$homeRoute/homeScreen';

  static String mediaDetailsRoute = '/mediaItemDetails';
  static String mediaDetailsControllerRoute = '$mediaDetailsRoute/controller';

  static String personDetailsRoute = '/personDetails';
  static String personDetailsControllerRoute = '$personDetailsRoute/controller';

  static String settingsRoute = '/settings';
}
