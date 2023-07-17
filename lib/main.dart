import 'package:FilmFlu/ui/screens/login/login_page.dart';
import 'package:FilmFlu/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FilmFlu());
}

class FilmFlu extends StatelessWidget {
  const FilmFlu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Film Flu',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Barlow',
          primaryColor: Color(0xFFC7CD18),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyMedium:
                TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'Barlow'),
          ),
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.yellow, backgroundColor: Color(0x10F0F)),
        ),
        darkTheme: ThemeData(
          primaryColor: Color(0xFFC7CD18),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.yellow, backgroundColor: Color(0x10F0F)),
        ),
        initialRoute: '',
        routes: {
          '': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage()
        });
  }
}
