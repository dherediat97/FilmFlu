import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalDataSource implements AppLocalDataSourceContract {
  final SharedPreferences sharedPreferencesInstance;

  AppLocalDataSource({
    required this.sharedPreferencesInstance,
  });

  @override
  Future<String> getLanguage() async {
    return sharedPreferencesInstance.getString(AppConstants.languageKey) ??
        'es';
  }

  @override
  Future<void> setLanguage(String value) async {
    if (await getLanguage() != '') {
      await sharedPreferencesInstance.setString(
          AppConstants.languageKey, value);
    } else {
      await sharedPreferencesInstance.setString(AppConstants.languageKey, 'es');
    }

    return;
  }

  @override
  Future<String> getThemeMode() async {
    return sharedPreferencesInstance.getString(AppConstants.themeModeKey) ??
        ThemeMode.system.name;
  }

  @override
  Future<void> setThemeMode(String value) async {
    if (await getThemeMode() != ThemeMode.system.name) {
      await sharedPreferencesInstance.setString(
          AppConstants.themeModeKey, value);
    } else {
      await sharedPreferencesInstance.setString(
          AppConstants.themeModeKey, ThemeMode.system.toString());
    }

    return;
  }
}
