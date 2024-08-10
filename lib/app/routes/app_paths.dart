class AppRoutePaths {
  static String startRoute = '/';

  static String homeRoute = '/main';
  static String homeControllerRoute = '$homeRoute/homeScreen';

  static String moviesRoute = '$homeRoute/movies';
  static String seriesRoute = '$homeRoute/series';
  static String searchRoute = '$homeRoute/search';

  static String mediaDetailsRoute = '/mediaItemDetails';
  static String mediaDetailsControllerRoute = '$mediaDetailsRoute/controller';

  static String personDetailsRoute = '/personDetails';
  static String personDetailsControllerRoute = '$personDetailsRoute/controller';

  static String settingsRoute = '/settings';
}
