import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(child: MediaList()),
      ),
    );
  }
}
