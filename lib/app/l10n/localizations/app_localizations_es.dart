///Film Flu Translations

import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_name => 'Film Flu';

  @override
  String get film_list_title => 'Novedades en Películas';

  @override
  String get search_film_hint => 'Busca aquí';

  @override
  String get synopsis => 'Sinopsis';

  @override
  String get character_cast => 'Reparto';

  @override
  String get production_cast => 'Producción';

  @override
  String get production_job => 'realizó el trabajo de';

  @override
  String get actor_job => 'Interpreta a';

  @override
  String get in_preposition => 'en';

  @override
  String get no_trailers => 'Esta película no tiene tráilers';

  @override
  String get tv_series_list_title => 'Novedades en Series';

  @override
  String get loading_title => '3,2,1 ACCIÓN!!!';

  @override
  String get films_not_found => 'No se han encontrado películas';
}
