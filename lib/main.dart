//Core Packages
import 'package:FilmFlu/ui/screens/main/main_page.dart';
import 'package:flutter/foundation.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//My Packages
import 'package:FilmFlu/ui/screens/login/login_page.dart';
import 'package:FilmFlu/ui/screens/splash/splash_screen.dart';
import 'package:FilmFlu/dto/movie_details_arguments.dart';
import 'package:FilmFlu/ui/screens/movieDetails/movie_details.dart';
import 'package:FilmFlu/ui/theme/colors.dart';
import 'package:FilmFlu/ui/util/utilScroll.dart';

void main() {
  runApp(const FilmFlu());
}

class FilmFlu extends StatelessWidget {
  const FilmFlu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: WebScrollBehavior(),
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
        scaffoldBackgroundColor: secondaryColor,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontFamily: 'YsabeauInfant',
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primaryMaterialColor,
          backgroundColor: backgroundColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scrollbarTheme: ScrollbarThemeData(
          radius: Radius.circular(20),
          thumbColor: MaterialStatePropertyAll(primaryColor),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == MovieDetailsPage.routeName) {
          final args = settings.arguments as MovieDetailsArguments;
          return MaterialPageRoute(
            builder: (context) {
              return ResponsiveScaledBox(
                  width: ResponsiveValue<double>(context, conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    Condition.between(start: 800, end: 1100, value: 800),
                    Condition.between(start: 1000, end: 1200, value: 1000),
                  ]).value,
                  child: BouncingScrollWrapper.builder(
                      context,
                      MovieDetailsPage(
                        movieId: args.movieId,
                      ),
                      dragWithMouse: true));
            },
          );
        } else {
          Widget screen;
          switch (settings.name) {
            case "/login":
              screen = LoginPage();
              break;
            default:
              screen = !kIsWeb ? SplashScreen() : MainPage();
              break;
          }
          return MaterialPageRoute(builder: (context) {
            return ResponsiveScaledBox(
              width: ResponsiveValue<double>(context, conditionalValues: [
                Condition.equals(name: MOBILE, value: 450),
                Condition.between(start: 800, end: 1100, value: 800),
                Condition.between(start: 1000, end: 1200, value: 1000),
              ]).value,
              child: BouncingScrollWrapper.builder(context, screen,
                  dragWithMouse: true),
            );
          });
        }
      },
    );
  }
}
