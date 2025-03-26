import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/app_bar/widgets/settings_app_bar_actions.dart';
import 'package:film_flu/presentation/features/settings/widgets/about_us_tab.dart';
import 'package:film_flu/presentation/features/settings/widgets/accessibility_tab.dart';
import 'package:film_flu/presentation/features/settings/widgets/general_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _index = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _index != 2
        ? Scaffold(
          appBar: AppBar(
            actions: [SettingsAppBarActions()],
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(
              context.localizations.settings,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultTabController(
              length: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.verified_user,
                          semanticLabel: context.localizations.general_sl,
                        ),
                        text: context.localizations.general,
                      ),
                      Tab(
                        icon: Icon(
                          Icons.settings_accessibility,
                          semanticLabel: context.localizations.accessibility_sl,
                        ),
                        text: context.localizations.accessibility,
                      ),
                      Tab(
                        icon: Icon(
                          Icons.help,
                          semanticLabel: context.localizations.about_us_sl,
                        ),
                        text: context.localizations.about_us,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 500,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [GeneralTab(), AccessibilityTab(), Container()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        : AboutUsTab();
  }
}
