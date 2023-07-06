import 'package:flutter/material.dart';

import '../../network/api.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Api api = Api();

  @override
  void initState() {
    super.initState();
    api.getMovies("es-ES", 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(),
    );
  }
}
