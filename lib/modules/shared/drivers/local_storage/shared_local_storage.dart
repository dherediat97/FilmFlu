import 'package:FilmFlu/modules/shared/drivers/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefLocalStorage implements LocalStorage {
  SharedPreferences? prefsInstance;

  @override
  Future<String> getString(String key) async {
    prefsInstance ??= await SharedPreferences.getInstance();
    return prefsInstance!.getString(key) ?? "";
  }

  @override
  Future<void> setString(String key, String string) async {
    prefsInstance ??= await SharedPreferences.getInstance();
    prefsInstance!.setString(key, string);
  }
}
