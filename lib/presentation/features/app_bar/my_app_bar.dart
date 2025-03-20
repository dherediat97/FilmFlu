import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/enums/media_type.dart';
import 'package:film_flu/presentation/features/app_bar/widgets/language_picker.dart';
import 'package:film_flu/presentation/features/search/search_view.dart';
import 'package:film_flu/presentation/notifiers/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TopAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const TopAppBar({
    super.key,
    this.mediaTypeSelected = MediaType.movie,
    this.isMainMenu = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(70);

  final MediaType? mediaTypeSelected;
  final bool isMainMenu;

  @override
  ConsumerState createState() => _TopAppBarState();
}

class _TopAppBarState extends ConsumerState<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SearchView(),
      automaticallyImplyLeading: true,
      titleTextStyle: Theme.of(context).textTheme.headlineLarge,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      leadingWidth: 80,
      leading:
          widget.isMainMenu
              ? IconButton(
                padding: EdgeInsets.zero,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                icon: Image.asset(AppAssets.logoIcon, fit: BoxFit.fitHeight),
                onPressed: () {
                  if (!widget.isMainMenu) {
                    context.pop();
                  } else {
                    context.go(AppRoutePaths.homeRoute);
                  }
                },
              )
              : null,
      actions: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(children: _appBarActions()),
        ),
      ],
    );
  }

  List<Widget> _appBarActions() {
    final languageProvider = ref.watch(appProvider.notifier);
    List<Widget> actions = [];

    actions.add(
      IconButton(
        icon: Icon(Icons.settings, color: AppColors.backgroundColorLight),
        onPressed: () => context.go(AppRoutePaths.settingsRoute),
      ),
    );

    actions.add(
      IconButton(
        icon: Icon(
          widget.isMainMenu ? Icons.light_mode : Icons.dark_mode,
          color: AppColors.backgroundColorLight,
        ),
        onPressed: () => ref.read(appProvider.notifier).toggle(),
      ),
    );

    actions.add(
      DropdownButton<Locale>(
        dropdownColor: widget.isMainMenu ? Colors.white : Colors.black,
        onChanged: (language) => languageProvider.changeLanguage(language!),
        selectedItemBuilder:
            (context) =>
                AppLocalizations.supportedLocales
                    .map(
                      (language) => LanguagePicker(
                        language: language,
                        isDropdown: false,
                        isMainMenu: widget.isMainMenu,
                      ),
                    )
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
                    child: LanguagePicker(
                      language: language,
                      isDropdown: true,
                      isMainMenu: widget.isMainMenu,
                    ),
                  ),
                )
                .toList(),
      ),
    );

    // actions.add(
    //   IconButton(
    //     icon: SvgPicture.asset(
    //       AppAssets.githubIcon,
    //       width: 24,
    //       height: 24,
    //       colorFilter: ColorFilter.mode(
    //         AppColors.backgroundColorLight,
    //         BlendMode.srcIn,
    //       ),
    //     ),
    //     onPressed: () {
    //       launchUrl(Uri.parse(AppConstants.myGithubPage));
    //     },
    //   ),
    // );

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
    // }
    return actions;
  }
}
