import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/presentation/features/app_bar/provider/app_language_provider.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/presentation/features/app_bar/widgets/language_picker.dart';
import 'package:film_flu/presentation/notifiers/app_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class TopAppBar extends ConsumerStatefulWidget {
  const TopAppBar({
    super.key,
    this.mediaTypeSelected = MediaType.movie,
    this.mainMenu = false,
  });

  final MediaType? mediaTypeSelected;
  final bool mainMenu;

  @override
  ConsumerState createState() => _TopAppBarState();
}

class _TopAppBarState extends ConsumerState<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = ref.watch(appLanguageProvider.notifier);

    return AppBar(
      title: titleScaffold(context, widget.mediaTypeSelected),
      automaticallyImplyLeading: true,
      titleTextStyle: Theme.of(context).textTheme.headlineLarge,
      backgroundColor: widget.mainMenu
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.primary,
      leadingWidth: 120,
      leading: IconButton(
          padding: EdgeInsets.zero,
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
          icon: Image.asset(
            AppAssets.logoIcon,
            fit: BoxFit.fitHeight,
          ),
          onPressed: () {
            if (!widget.mainMenu) {
              context.pop();
            } else {
              context.go(AppRoutePaths.moviesRoute);
            }
          }),
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: _appBarActions(languageProvider),
          ),
        )
      ],
    );
  }

  List<Widget> _appBarActions(AppLanguageNotifier languageProvider) {
    List<Widget> actions = [];

    // actions.add(
    //   IconButton(
    //     icon: Icon(
    //       Icons.settings,
    //       color: Theme.of(context).colorScheme.onSecondary,
    //     ),
    //     onPressed: () {
    //       context.go(AppRoutePaths.settingsRoute);
    //     },
    //   ),
    // );

    actions.add(
      IconButton(
        icon: Icon(
          widget.mainMenu ? Icons.light_mode : Icons.dark_mode,
        ),
        onPressed: () {
          ref.read(appProvider.notifier).toggle();
        },
      ),
    );

    actions.add(DropdownButton<Locale>(
        dropdownColor: widget.mainMenu ? Colors.white : Colors.white,
        onChanged: (language) {
          languageProvider.changeLanguage(language!);
        },
        selectedItemBuilder: (context) =>
            AppLocalizations.supportedLocales.map<Widget>((Locale language) {
              return LanguagePicker(
                language: language,
                isDropdown: false,
                isMainMenu: widget.mainMenu,
              );
            }).toList(),
        padding: const EdgeInsets.all(8),
        elevation: 4,
        value: ref.watch(appLanguageProvider),
        underline: const SizedBox(height: 0),
        items: AppLocalizations.supportedLocales
            .map<DropdownMenuItem<Locale>>((Locale language) {
          return DropdownMenuItem<Locale>(
            value: language,
            child: LanguagePicker(
              language: language,
              isDropdown: true,
              isMainMenu: widget.mainMenu,
            ),
          );
        }).toList()));

    actions.add(
      IconButton(
        icon: SvgPicture.asset(
          AppAssets.githubIcon,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
              AppColors.backgroundColorLight, BlendMode.srcIn),
        ),
        onPressed: () {
          launchUrl(Uri.parse(AppConstants.myGithubPage));
        },
      ),
    );

    if (kIsWeb) {
      actions.add(
        IconButton(
          onPressed: () async {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            AppConstants.version = packageInfo.version;

            final Uri url = Uri.parse(AppConstants.appDownloadBaseUrl);
            //Lanzar url que descarga la app para android
            await launchUrl(url);
          },
          icon: const Icon(
            Icons.android,
          ),
        ),
      );
    }
    return actions;
  }

  Widget titleScaffold(BuildContext context, mediaTypeSelected) {
    if (mediaTypeSelected != MediaType.movie &&
        mediaTypeSelected != MediaType.tv) {
      return SearchBar(onChanged: (value) {});
    } else {
      return Container();
    }
  }
}
