import 'package:FilmFlu/ui/components/movie_item.dart';
import 'package:FilmFlu/ui/screens/login/login_page.dart';
import 'package:FilmFlu/ui/screens/main/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FilmFlu());
}

class FilmFlu extends StatelessWidget {
  const FilmFlu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flim Flu',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.deepOrange),
          ),
        ),
        darkTheme: ThemeData(
          primaryColor: Colors.deepOrange,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange),
        ),
        initialRoute: "/home",
        routes: {
          "/home": (context) => const MainPage(),
          "/login": (context) => const LoginPage(),
          "/movie": (context) => const MovieItem(),
        });
  }
}
