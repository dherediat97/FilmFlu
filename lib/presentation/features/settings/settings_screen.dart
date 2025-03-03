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

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _setPackageInfo();
    _addLicenses();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            context.localizations.settings,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          bottom: TabBar(
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
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text('Dark mode'),
                  Switch(
                    value: ref.watch(appProvider).isDarkMode,
                    onChanged: (value) =>
                        ref.watch(appProvider.notifier).toggle(),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: LicensePage(
              applicationIcon: Image.asset(AppAssets.logoIcon),
              applicationLegalese:
                  '© ${DateTime.now().year} ${context.localizations.app_name}',
              applicationName: '',
              applicationVersion: _packageInfo?.version ?? '',
            ),
          ),
        ]),
      ),
    );
  }

  _addLicenses() {
    LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
          const LicenseEntryWithLineBreaks(
            <String>['iconscout'],
            '''
        *<a href="https://iconscout.com/icons/spain" class="text-underline font-size-sm" target="_blank">Spain</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/england" class="text-underline font-size-sm" target="_blank">England</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/france" class="text-underline font-size-sm" target="_blank">France</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/japan" class="text-underline font-size-sm" target="_blank">Japan</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/south_korea" class="text-underline font-size-sm" target="_blank">South Korea</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>'
        *<a href="https://iconscout.com/icons/germany" class="text-underline font-size-sm" target="_blank">Germany</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
        *<a href="https://iconscout.com/icons/italy" class="text-underline font-size-sm" target="_blank">Italy</a> by <a href="https://iconscout.com/contributors/uipixi" class="text-underline font-size-sm" target="_blank">Uipixi</a>
            ''',
          ),
        ));

    LicenseRegistry.addLicense(
      () => Stream<LicenseEntry>.value(
        const LicenseEntryWithLineBreaks(<String>['freepik'],
            'Icons designed by Freepik from www.freepik.com'),
      ),
    );
  }

  Future<void> _setPackageInfo() async => PackageInfo.fromPlatform().then(
        (PackageInfo packageInfo) => setState(() => _packageInfo = packageInfo),
      );
}
