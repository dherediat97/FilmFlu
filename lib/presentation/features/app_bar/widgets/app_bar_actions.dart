import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/domain/enums/settings_tab.dart';
import 'package:film_flu/presentation/notifiers/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarActions extends ConsumerStatefulWidget {
  const AppBarActions({super.key, required this.isMainMenu});

  final bool isMainMenu;

  @override
  ConsumerState<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends ConsumerState<AppBarActions> {
  @override
  Widget build(BuildContext context) {
    final settingsNotifier = ref.read(settingsProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.settings, color: AppColors.backgroundColorLight),
            onPressed: () {
              settingsNotifier.setTabSelected(SettingsTab.general);
              SettingsRoute().push(context);
            },
          ),
        ],
      ),
    );
  }
}
