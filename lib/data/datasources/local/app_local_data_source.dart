import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalDataSource implements AppLocalDataSourceContract {
  final SharedPreferences sharedPreferencesInstance;
  final String _languageKey = 'languageCode';

  AppLocalDataSource({
    required this.sharedPreferencesInstance,
  });

  @override
  Future<String> getLanguage() async {
    return sharedPreferencesInstance.getString(_languageKey) ?? 'es';
  }

  @override
  Future<void> setLanguage(String value) async {
    if (await getLanguage() != '') {
      await sharedPreferencesInstance.setString(_languageKey, value);
    } else {
      await sharedPreferencesInstance.setString(_languageKey, 'es');
    }

    return;
  }
}
