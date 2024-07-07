///Film Flu Translations

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Film Flu';

  @override
  String get film_list_title => 'Drama Film Playing';

  @override
  String get search_film_hint => 'Search here';

  @override
  String get synopsis => 'Synopsis';

  @override
  String get character_cast => 'Character Cast';

  @override
  String get production_cast => 'Production';

  @override
  String get production_job => 'Performed the work of';

  @override
  String get actor_job => 'Play';

  @override
  String get in_preposition => 'in';

  @override
  String get no_trailers => 'This film haven\'t trailer';

  @override
  String get tv_series_list_title => 'Anime Playing';

  @override
  String get loading_title => '3, 2, 1 ACTION !!!';

  @override
  String get films_not_found => 'Films not found';

  @override
  String get made_with_love => 'Made with much';
}
