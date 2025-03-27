import 'package:film_flu/presentation/features/app_bar/top_app_bar.dart';
import 'package:film_flu/presentation/features/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldPage extends ConsumerStatefulWidget {
  const ScaffoldPage({
    super.key,
    required this.child,
    this.floatingActionButton,
  });

  final Widget child;
  final Widget? floatingActionButton;

  @override
  ConsumerState<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends ConsumerState<ScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      appBar: TopAppBar(),
      bottomNavigationBar: BottomBar(),
      body: widget.child,
    );
  }
}
