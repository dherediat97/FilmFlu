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
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

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
    Locale('ko'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('sk'),
    Locale('sv'),
    Locale('zh')
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

  /// No description provided for @action_type.
  ///
  /// In es, this message translates to:
  /// **'Acción'**
  String get action_type;

  /// No description provided for @adventure_type.
  ///
  /// In es, this message translates to:
  /// **'Aventura'**
  String get adventure_type;

  /// No description provided for @animation_type.
  ///
  /// In es, this message translates to:
  /// **'Animadas'**
  String get animation_type;

  /// No description provided for @crime_type.
  ///
  /// In es, this message translates to:
  /// **'de Crimen'**
  String get crime_type;

  /// No description provided for @family_type.
  ///
  /// In es, this message translates to:
  /// **'Familiares'**
  String get family_type;

  /// No description provided for @fantasy_type.
  ///
  /// In es, this message translates to:
  /// **'Fantásicas'**
  String get fantasy_type;

  /// No description provided for @comedy_type.
  ///
  /// In es, this message translates to:
  /// **'Comedia'**
  String get comedy_type;

  /// No description provided for @history_type.
  ///
  /// In es, this message translates to:
  /// **'Históricas'**
  String get history_type;

  /// No description provided for @horror_type.
  ///
  /// In es, this message translates to:
  /// **'De Miedo'**
  String get horror_type;

  /// No description provided for @fiction_type.
  ///
  /// In es, this message translates to:
  /// **'De ciencia ficción'**
  String get fiction_type;

  /// No description provided for @music_type.
  ///
  /// In es, this message translates to:
  /// **'Musicales'**
  String get music_type;

  /// No description provided for @love_type.
  ///
  /// In es, this message translates to:
  /// **'Románticas'**
  String get love_type;

  /// No description provided for @western_type.
  ///
  /// In es, this message translates to:
  /// **'Vaqueras'**
  String get western_type;

  /// No description provided for @mistery_type.
  ///
  /// In es, this message translates to:
  /// **'Misterio'**
  String get mistery_type;

  /// No description provided for @war_type.
  ///
  /// In es, this message translates to:
  /// **'Bélicas'**
  String get war_type;

  /// No description provided for @documentary_type.
  ///
  /// In es, this message translates to:
  /// **'Documentales'**
  String get documentary_type;

  /// No description provided for @tv_type.
  ///
  /// In es, this message translates to:
  /// **'Programas de televisión'**
  String get tv_type;

  /// No description provided for @animation_japanese_series.
  ///
  /// In es, this message translates to:
  /// **'Anime Japonés'**
  String get animation_japanese_series;

  /// No description provided for @drama_type.
  ///
  /// In es, this message translates to:
  /// **'Drama'**
  String get drama_type;

  /// No description provided for @thriller_type.
  ///
  /// In es, this message translates to:
  /// **'Suspense'**
  String get thriller_type;

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

  /// No description provided for @search.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get search;

  /// No description provided for @percentange_vote.
  ///
  /// In es, this message translates to:
  /// **'% de los usuarios les gusta'**
  String get percentange_vote;

  /// No description provided for @buy_tickets.
  ///
  /// In es, this message translates to:
  /// **'Reserva entradas'**
  String get buy_tickets;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fi', 'fr', 'hi', 'is', 'it', 'ja', 'ko', 'nl', 'pl', 'pt', 'sk', 'sv', 'zh'].contains(locale.languageCode);

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
    case 'ko': return AppLocalizationsKo();
    case 'nl': return AppLocalizationsNl();
    case 'pl': return AppLocalizationsPl();
    case 'pt': return AppLocalizationsPt();
    case 'sk': return AppLocalizationsSk();
    case 'sv': return AppLocalizationsSv();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
