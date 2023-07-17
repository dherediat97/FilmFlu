import 'package:FilmFlu/ui/screens/login/login_page.dart';
import 'package:FilmFlu/ui/screens/main/main_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
          '': (context) => const MainPage(),
          '/login': (context) => const LoginPage()
        });
  }
}
