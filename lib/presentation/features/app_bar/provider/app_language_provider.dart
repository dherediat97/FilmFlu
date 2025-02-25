import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageNotifier extends StateNotifier<Locale> {
  AppLanguageNotifier() : super(const Locale('es'));

  Future<void> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode != null) {
      state = Locale(languageCode);
    }
  }

  Future<void> changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (state != type) {
      state = type;
      await prefs.setString('language_code', type.languageCode);
    }
  }
}

final appLanguageProvider =
    StateNotifierProvider<AppLanguageNotifier, Locale>((ref) {
  final notifier = AppLanguageNotifier();
  notifier.fetchLocale();
  return notifier;
});
