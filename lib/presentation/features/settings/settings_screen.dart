import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/enums/settings_tab.dart';
import 'package:film_flu/presentation/features/app_bar/widgets/settings_app_bar_actions.dart';
import 'package:film_flu/presentation/features/settings/widgets/about_us_tab.dart';
import 'package:film_flu/presentation/features/settings/widgets/accessibility_tab.dart';
import 'package:film_flu/presentation/features/settings/widgets/general_tab.dart';
import 'package:film_flu/presentation/notifiers/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Widget child = GeneralTab();
    final state = ref.watch(settingsProvider);

    switch (state) {
      case SettingsTab.general:
        child = const GeneralTab();
        break;
      case SettingsTab.accessibility:
        child = const AccessibilityTab();
        break;
      case SettingsTab.aboutus:
        break;
    }

    return state != SettingsTab.aboutus
        ? Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerLowest,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            currentIndex: ref.watch(settingsProvider).index,
            elevation: 20,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.verified_user,
                  semanticLabel: context.localizations.general_sl,
                ),
                label: context.localizations.general,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_accessibility,
                  semanticLabel: context.localizations.accessibility_sl,
                ),
                label: context.localizations.accessibility,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.help,
                  semanticLabel: context.localizations.about_us_sl,
                ),
                label: context.localizations.about_us,
              ),
            ],
            onTap:
                (int index) => ref
                    .watch(settingsProvider.notifier)
                    .setTabSelected(switch (index) {
                      0 => SettingsTab.general,
                      1 => SettingsTab.accessibility,
                      _ => SettingsTab.general,
                    }),
          ),
          appBar: AppBar(
            actions: [SettingsAppBarActions()],
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(
              context.localizations.settings,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          body: child,
        )
        : AboutUsTab();
  }
}
