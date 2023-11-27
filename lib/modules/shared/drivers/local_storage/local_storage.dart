abstract class LocalStorage {
  Future<String> getString(String key);
  Future<void> setString(String key, String string);
}
