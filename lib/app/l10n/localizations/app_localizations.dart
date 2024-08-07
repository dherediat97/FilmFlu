///Film Flu Translations
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_is.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sv.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localizations/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fi'),
    Locale('fr'),
    Locale('hi'),
    Locale('is'),
    Locale('it'),
    Locale('ja'),
    Locale('nl'),
    Locale('pt'),
    Locale('sk'),
    Locale('sv')
  ];

  /// No description provided for @app_name.
  ///
  /// In es, this message translates to:
  /// **'Film Flu'**
  String get app_name;

  /// No description provided for @movies.
  ///
  /// In es, this message translates to:
  /// **'Películas'**
  String get movies;

  /// No description provided for @series.
  ///
  /// In es, this message translates to:
  /// **'Series'**
  String get series;

  /// No description provided for @action_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de acción'**
  String get action_movies;

  /// No description provided for @adventure_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de aventura'**
  String get adventure_movies;

  /// No description provided for @animation_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de animación'**
  String get animation_movies;

  /// No description provided for @crime_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de crimen'**
  String get crime_movies;

  /// No description provided for @family_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de familia'**
  String get family_movies;

  /// No description provided for @fantasy_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de fantasía'**
  String get fantasy_movies;

  /// No description provided for @history_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de historia'**
  String get history_movies;

  /// No description provided for @horror_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de horror'**
  String get horror_movies;

  /// No description provided for @music_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de música'**
  String get music_movies;

  /// No description provided for @tv_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de televisión'**
  String get tv_movies;

  /// No description provided for @war_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de guerra'**
  String get war_movies;

  /// No description provided for @western_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas del oeste'**
  String get western_movies;

  /// No description provided for @drama_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de drama'**
  String get drama_movies;

  /// No description provided for @comedy_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de comedia'**
  String get comedy_movies;

  /// No description provided for @thriller_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de suspense'**
  String get thriller_movies;

  /// No description provided for @fiction_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de ciencia ficción'**
  String get fiction_movies;

  /// No description provided for @love_movies.
  ///
  /// In es, this message translates to:
  /// **'Películas de romance'**
  String get love_movies;

  /// No description provided for @animation_series.
  ///
  /// In es, this message translates to:
  /// **'Series de animación'**
  String get animation_series;

  /// No description provided for @documental_series.
  ///
  /// In es, this message translates to:
  /// **'Documentales'**
  String get documental_series;

  /// No description provided for @tv_show_series.
  ///
  /// In es, this message translates to:
  /// **'Programas de Televisión'**
  String get tv_show_series;

  /// No description provided for @action_adventure_series.
  ///
  /// In es, this message translates to:
  /// **'Series de acción y aventura'**
  String get action_adventure_series;

  /// No description provided for @crime_series.
  ///
  /// In es, this message translates to:
  /// **'Series de crimen'**
  String get crime_series;

  /// No description provided for @family_series.
  ///
  /// In es, this message translates to:
  /// **'Series de familia'**
  String get family_series;

  /// No description provided for @kids_series.
  ///
  /// In es, this message translates to:
  /// **'Series para niños'**
  String get kids_series;

  /// No description provided for @reality_series.
  ///
  /// In es, this message translates to:
  /// **'Realitys'**
  String get reality_series;

  /// No description provided for @talk_series.
  ///
  /// In es, this message translates to:
  /// **'Programas informativos'**
  String get talk_series;

  /// No description provided for @mistery_series.
  ///
  /// In es, this message translates to:
  /// **'Series de misterio'**
  String get mistery_series;

  /// No description provided for @history_series.
  ///
  /// In es, this message translates to:
  /// **'Series de historia'**
  String get history_series;

  /// No description provided for @horror_series.
  ///
  /// In es, this message translates to:
  /// **'Series de horror'**
  String get horror_series;

  /// No description provided for @music_series.
  ///
  /// In es, this message translates to:
  /// **'Series de música'**
  String get music_series;

  /// No description provided for @tv_series.
  ///
  /// In es, this message translates to:
  /// **'Series de televisión'**
  String get tv_series;

  /// No description provided for @war_series.
  ///
  /// In es, this message translates to:
  /// **'Series de guerra'**
  String get war_series;

  /// No description provided for @western_series.
  ///
  /// In es, this message translates to:
  /// **'Series del oeste'**
  String get western_series;

  /// No description provided for @drama_series.
  ///
  /// In es, this message translates to:
  /// **'Series de drama'**
  String get drama_series;

  /// No description provided for @comedy_series.
  ///
  /// In es, this message translates to:
  /// **'Series de comedia'**
  String get comedy_series;

  /// No description provided for @thriller_series.
  ///
  /// In es, this message translates to:
  /// **'Series de suspense'**
  String get thriller_series;

  /// No description provided for @fiction_series.
  ///
  /// In es, this message translates to:
  /// **'Series de ciencia ficción y fantasía'**
  String get fiction_series;

  /// No description provided for @love_series.
  ///
  /// In es, this message translates to:
  /// **'Series de romance'**
  String get love_series;

  /// No description provided for @synopsis.
  ///
  /// In es, this message translates to:
  /// **'Sinopsis'**
  String get synopsis;

  /// No description provided for @character_cast.
  ///
  /// In es, this message translates to:
  /// **'Reparto'**
  String get character_cast;

  /// No description provided for @production_cast.
  ///
  /// In es, this message translates to:
  /// **'Producción'**
  String get production_cast;

  /// No description provided for @production_job.
  ///
  /// In es, this message translates to:
  /// **'Realizó el trabajo de'**
  String get production_job;

  /// No description provided for @actor_job.
  ///
  /// In es, this message translates to:
  /// **'Interpreta a'**
  String get actor_job;

  /// No description provided for @in_preposition.
  ///
  /// In es, this message translates to:
  /// **'en'**
  String get in_preposition;

  /// No description provided for @loading_title.
  ///
  /// In es, this message translates to:
  /// **'Tres, Dos, Uno... ACCIÓN!!!'**
  String get loading_title;

  /// No description provided for @made_with_love.
  ///
  /// In es, this message translates to:
  /// **'Hecho con mucho'**
  String get made_with_love;

  /// No description provided for @play_trailer.
  ///
  /// In es, this message translates to:
  /// **'Ver tráiler'**
  String get play_trailer;

  /// No description provided for @films_worked.
  ///
  /// In es, this message translates to:
  /// **'Papeles que ha realizado'**
  String get films_worked;

  /// No description provided for @about_movie.
  ///
  /// In es, this message translates to:
  /// **'Sobre la Película'**
  String get about_movie;

  /// No description provided for @about_serie.
  ///
  /// In es, this message translates to:
  /// **'Sobre la Serie'**
  String get about_serie;

  /// No description provided for @reviews.
  ///
  /// In es, this message translates to:
  /// **'Reseñas'**
  String get reviews;

  /// No description provided for @information.
  ///
  /// In es, this message translates to:
  /// **'Información'**
  String get information;

  /// No description provided for @add_to_my_list.
  ///
  /// In es, this message translates to:
  /// **'Añadir a mi lista'**
  String get add_to_my_list;

  /// No description provided for @unknown.
  ///
  /// In es, this message translates to:
  /// **'Desconocido'**
  String get unknown;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fi', 'fr', 'hi', 'is', 'it', 'ja', 'nl', 'pt', 'sk', 'sv'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fi': return AppLocalizationsFi();
    case 'fr': return AppLocalizationsFr();
    case 'hi': return AppLocalizationsHi();
    case 'is': return AppLocalizationsIs();
    case 'it': return AppLocalizationsIt();
    case 'ja': return AppLocalizationsJa();
    case 'nl': return AppLocalizationsNl();
    case 'pt': return AppLocalizationsPt();
    case 'sk': return AppLocalizationsSk();
    case 'sv': return AppLocalizationsSv();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
