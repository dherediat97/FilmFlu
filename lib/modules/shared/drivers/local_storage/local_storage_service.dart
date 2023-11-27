import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String LANGUAGE_CODE_KEY = 'languageCodeApp';

//languages code
const String ENGLISH = 'en';
const String SPANISH = 'es';
const String FRENCH = 'fr';
const String ITALIAN = 'it';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE_KEY, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE_KEY) ?? SPANISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, "EN");
    case SPANISH:
      return const Locale(SPANISH, "ES");
    case FRENCH:
      return const Locale(FRENCH, "FR");
    case ITALIAN:
      return const Locale(ITALIAN, "IT");
    default:
      return const Locale(SPANISH, "ES");
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
