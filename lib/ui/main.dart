import 'package:filmflu/ui/screens/mainPage.dart';
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        home: const MainPage(title: 'Flim Flu'));
  }
}