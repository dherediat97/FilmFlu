import 'package:FilmFlu/ui/screens/main_page.dart';
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
        color: Colors.black,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MainPage(title: 'Flim Flu'));
  }
}
