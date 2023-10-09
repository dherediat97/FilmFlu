import 'package:FilmFlu/ui/components/scaffold_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      routeName: "Ajustes",
      containerChild: Container(
        child: Row(),
      ),
      isLightsOn: true,
      isSearchVisible: false,
    );
  }
}
