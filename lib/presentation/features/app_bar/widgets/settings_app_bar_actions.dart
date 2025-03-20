import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/presentation/features/app_bar/widgets/language_picker.dart';
import 'package:film_flu/presentation/notifiers/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsAppBarActions extends ConsumerStatefulWidget {
  const SettingsAppBarActions({super.key, required this.isMainMenu});

  final bool isMainMenu;

  @override
  ConsumerState<SettingsAppBarActions> createState() =>
      _SettingsAppBarActionsState();
}

class _SettingsAppBarActionsState extends ConsumerState<SettingsAppBarActions> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = ref.watch(appProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              widget.isMainMenu ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () => ref.read(appProvider.notifier).toggle(),
          ),
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.githubIcon,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              launchUrl(Uri.parse(AppConstants.myGithubPage));
            },
          ),
          DropdownButton<Locale>(
            dropdownColor: Theme.of(context).colorScheme.surface,
            onChanged: (language) => languageProvider.changeLanguage(language!),
            selectedItemBuilder:
                (context) =>
                    AppLocalizations.supportedLocales
                        .map((language) => LanguagePicker(language: language))
                        .toList(),
            padding: const EdgeInsets.all(8),
            elevation: 4,
            value: ref.watch(appProvider).appLocale,
            underline: const SizedBox(height: 0),
            items:
                AppLocalizations.supportedLocales
                    .map(
                      (language) => DropdownMenuItem<Locale>(
                        value: language,
                        child: LanguagePicker(language: language),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );

    // if (kIsWeb) {
    //   actions.add(
    //     IconButton(
    //       onPressed: () async {
    //         PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //         AppConstants.version = packageInfo.version;

    //         final Uri url = Uri.parse(AppConstants.appDownloadBaseUrl);
    //         //Lanzar url que descarga la app para android
    //         await launchUrl(url);
    //       },
    //       icon: Icon(
    //         Icons.android,
    //         color: AppColors.backgroundColorLight,
    //       ),
    //     ),
    //   );
    // }();
  }
}
