abstract class AppLocalDataSourceContract {
  Future<String> getLanguage();

  Future<void> setLanguage(String value);

  Future<String> getThemeMode();

  Future<void> setDarkMode(bool value);
}
