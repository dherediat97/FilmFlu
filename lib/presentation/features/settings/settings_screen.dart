import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/notifiers/app_notifier.dart';
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
                          children: [
                            Column(
                              children: [
                                Text('Dark mode'),
                                Switch(
                                  value: ref.watch(appProvider).isDarkMode,
                                  onChanged:
                                      (value) =>
                                          ref
                                              .watch(appProvider.notifier)
                                              .toggle(),
                                ),
                              ],
                            ),
                          ],
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
        *<a href="https://iconscout.com/icons/spain" class="text-underline font-size-sm" target="_blank">Spain</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/england" class="text-underline font-size-sm" target="_blank">England</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/china" class="text-underline font-size-sm" target="_blank">China</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/poland" class="text-underline font-size-sm" target="_blank">Poland</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/portugal" class="text-underline font-size-sm" target="_blank">Portugal</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/france" class="text-underline font-size-sm" target="_blank">France</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/japan" class="text-underline font-size-sm" target="_blank">Japan</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/south_korea" class="text-underline font-size-sm" target="_blank">South Korea</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>'
        *<a href="https://iconscout.com/icons/germany" class="text-underline font-size-sm" target="_blank">Germany</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/italy" class="text-underline font-size-sm" target="_blank">Italy</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
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
