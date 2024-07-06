abstract class AppLocalDataSourceContract {
  Future<String> getLanguage();

  Future<void> setLanguage(String value);
}
