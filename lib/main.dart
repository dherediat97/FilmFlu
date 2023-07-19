//Core Packages
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
          primaryColor: Color(0xFFC7CD18),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'Barlow',
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.yellow,
            backgroundColor: Color(0x10F0F),
          ),
        ),
        darkTheme: ThemeData(
          primaryColor: Color(0xFFC7CD18),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.yellow,
            backgroundColor: Color(0x10F0F),
          ),
        ),
        initialRoute: '',
        routes: {
          '': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage()
        });
  }
}
