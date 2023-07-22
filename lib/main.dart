//Core Packages
import 'package:FilmFlu/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//My Packages
import 'package:FilmFlu/ui/screens/login/login_page.dart';
import 'package:FilmFlu/ui/screens/splash/splash_screen.dart';

void main() {
  runApp(const FilmFlu());
}

class FilmFlu extends StatelessWidget {
  const FilmFlu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        onGenerateTitle: (context) => AppLocalizations.of(context)!.app_name,
        supportedLocales: [Locale('en'), Locale('es')],
        theme: ThemeData(
          fontFamily: 'Barlow',
          primaryColor: primaryColor,
          useMaterial3: true,
          scaffoldBackgroundColor: secondaryColor,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'Barlow',
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: primaryMaterialColor,
            backgroundColor: backgroundColor,
          ),
        ),
        darkTheme: ThemeData(
          primaryColor: primaryColor,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: primaryMaterialColor,
            backgroundColor: secondaryColor,
          ),
        ),
        initialRoute: '',
        routes: {
          '': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage()
        });
  }
}
