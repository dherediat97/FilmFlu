import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutUsTab extends StatefulWidget {
  const AboutUsTab({super.key});

  @override
  State<AboutUsTab> createState() => _AboutUsTabState();
}

class _AboutUsTabState extends State<AboutUsTab> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _setPackageInfo();
    _addLicenses();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        * Spain Flag by Uipixi
        * England Flag by Uipixi
        * China Flag by Uipixi
        * Poland Flag by Uipixi
        * Portugal Flag by Uipixi
        * France Flag by Uipixi
        * Japan Flag by Uipixi
        * South Korea Flag by Uipixi'
        * Germany Flag by Uipixi
        * Italy Flag by Uipixi
        * Finland Flag by Uipixi
        * India Flag by Uipixi
        * Iceland Flag by Uipixi
        * Netherlands Flag by Uipixi
        * Sweden Flag by Uipixi
        * Slovakia Flag by Uipixi
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
