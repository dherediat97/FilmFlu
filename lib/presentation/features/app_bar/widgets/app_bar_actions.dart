import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppBarActions extends ConsumerStatefulWidget {
  const AppBarActions({super.key, required this.isMainMenu});

  final bool isMainMenu;

  @override
  ConsumerState<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends ConsumerState<AppBarActions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.settings, color: AppColors.backgroundColorLight),
            onPressed: () => context.go(AppRoutePaths.settingsRoute),
          ),
        ],
      ),
    );
  }
}
