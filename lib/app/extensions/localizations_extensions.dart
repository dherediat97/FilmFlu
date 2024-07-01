import 'package:FilmFlu/app/l10n/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this);
}
