//Core Packages
import 'package:FilmFlu/ui/util/utilScroll.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//My Packages
import 'package:FilmFlu/ui/pages/login/login_page.dart';
import 'package:FilmFlu/dto/base_arguments.dart';
import 'package:FilmFlu/ui/pages/movieDetails/movie_details.dart';
import 'package:FilmFlu/ui/theme/colors.dart';
import 'package:FilmFlu/ui/pages/main/main_screen.dart';
import 'package:FilmFlu/ui/pages/personDetails/actor_details.dart';
import 'package:FilmFlu/ui/pages/settings/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: true,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  //Setting SystemUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  runApp(const FilmFlu());
}

class FilmFlu extends StatelessWidget {
  const FilmFlu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: kIsWeb ? WebScrollBehavior() : MaterialScrollBehavior(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      onGenerateTitle: (context) => AppLocalizations.of(context)!.app_name,
      supportedLocales: [
        Locale('es'),
        Locale('en'),
        Locale('fr'),
        Locale('de'),
        Locale('nl'),
        Locale('is'),
      ],
      theme: ThemeData(
        fontFamily: 'YsabeauInfant',
        primaryColor: primaryColor,
        useMaterial3: true,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontFamily: 'YsabeauInfant',
          ),
        ),
        splashFactory: NoSplash.splashFactory,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primaryMaterialColor,
          backgroundColor: backgroundColor,
          accentColor: backgroundColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scrollbarTheme: ScrollbarThemeData(
          radius: Radius.circular(20),
          thumbColor: MaterialStatePropertyAll(primaryColor),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        BaseArguments? args;
        if (settings.arguments != null)
          args = settings.arguments as BaseArguments;
        Widget screen;
        switch (settings.name) {
          case "/login":
            screen = LoginPage();
            break;
          case "/movieDetails":
            screen = MovieDetailsPage(
                movieId: args!.movieId,
                isTrailerSelected: args.isTrailerSelected,
                isFilm: args.isFilm);
            break;
          case "/actorDetails":
            screen = ActorDetailsPage(actorId: args!.actorId);
            break;
          case "/settings":
            screen = SettingsPage();
            break;
          default:
            screen = MainPage();
            break;
        }
        return MaterialPageRoute(builder: (context) {
          return ResponsiveScaledBox(
            width: ResponsiveValue<double>(context, conditionalValues: [
              Condition.equals(name: MOBILE, value: 450),
              Condition.between(start: 800, end: 1100, value: 800),
              Condition.between(start: 1000, end: 1200, value: 1000),
            ]).value,
            autoCalculateMediaQueryData: true,
            child: BouncingScrollWrapper.builder(
              context,
              screen,
              dragWithMouse: true,
            ),
          );
        });
      },
    );
  }
}
