import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/app_bar/widgets/settings_app_bar_actions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with SingleTickerProviderStateMixin {
  PackageInfo? _packageInfo;
  late TabController _tabController;
  var _index = 0;

  @override
  void initState() {
    super.initState();
    _setPackageInfo();
    _addLicenses();
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
                        icon: Icon(Icons.verified_user),
                        text: context.localizations.general,
                      ),
                      Tab(
                        icon: Icon(Icons.settings_accessibility),
                        text: context.localizations.advanced,
                      ),
                      Tab(
                        icon: Icon(Icons.help),
                        text: context.localizations.about_us,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 500,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        : Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: LicensePage(
            applicationIcon: Image.asset(AppAssets.logoIcon),
            applicationLegalese:
                '© ${DateTime.now().year} ${context.localizations.app_name}',
            applicationName: '',
            applicationVersion: _packageInfo?.version ?? '',
          ),
        );
  }

  _addLicenses() {
    LicenseRegistry.addLicense(
      () => Stream<LicenseEntry>.value(
        const LicenseEntryWithLineBreaks(
          <String>['iconscout'],
          '''
        *Spain Flag by Uipixi
        *England Flag by Uipixi
        *China Flag by Uipixi
        *Poland Flag by Uipixi
        *Portugal Flag by Uipixi
        *France Flag by Uipixi
        *Japan Flag by Uipixi
        *South Korea Flag by Uipixi'
        *Germany Flag by Uipixi
        *Italy Flag by Uipixi
        *Finland Flag by Uipixi
        *India Flag by Uipixi
        *Iceland Flag by Uipixi
        *Netherlands Flag by Uipixi
        *Sweden Flag by Uipixi
        *Slovakia Flag by Uipixi
            ''',
        ),
      ),
    );

    LicenseRegistry.addLicense(
      () => Stream<LicenseEntry>.value(
        const LicenseEntryWithLineBreaks(<String>[
          'freepik',
        ], 'Images designed by Freepik from www.freepik.com'),
      ),
    );
  }

  Future<void> _setPackageInfo() async => PackageInfo.fromPlatform().then(
    (PackageInfo packageInfo) => setState(() => _packageInfo = packageInfo),
  );
}
