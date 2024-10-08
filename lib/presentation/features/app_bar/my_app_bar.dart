import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/search/bloc/search_bloc.dart';
import 'package:film_flu/presentation/top_blocs/app/app_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.mediaTypeSelected = MediaType.movie,
  });

  final MediaType? mediaTypeSelected;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleScaffold(context, mediaTypeSelected),
      automaticallyImplyLeading: true,
      titleTextStyle: Theme.of(context).textTheme.headlineLarge,
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
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutePaths.moviesRoute);
            }
          }),
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: _appBarActions(context),
          ),
        )
      ],
    );
  }

  List<Widget> _appBarActions(BuildContext context) {
    List<Widget> actions = [];

    bool isLightMode =
        ThemeMode.dark == context.read<AppBloc>().state.themeMode;

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
          isLightMode ? Icons.light_mode : Icons.dark_mode,
        ),
        onPressed: () {
          context.read<AppBloc>().add(AppEvent.toogleTheme(isLightMode));
        },
      ),
    );

    actions.add(DropdownButton<Locale>(
        iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
        onChanged: (language) {
          context
              .read<AppBloc>()
              .add(AppEvent.changeLang(language?.toString() ?? 'es'));
          context.push(AppRoutePaths.startRoute);
        },
        padding: const EdgeInsets.all(8),
        dropdownColor: Theme.of(context).colorScheme.surface,
        value: context.read<AppBloc>().state.locale,
        underline: const SizedBox(height: 0),
        items: AppLocalizations.supportedLocales
            .map<DropdownMenuItem<Locale>>((Locale language) {
          return DropdownMenuItem<Locale>(
            value: language,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/flags/${language.languageCode}_flag.svg',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40),
                Text(
                  language.languageCode,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
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
      return SearchBar(onChanged: (value) {
        context.read<SearchBloc>().add(SearchEvent.searchMovie(
              query: value,
              movieFilters: const MovieFilters(),
            ));
      });
    } else {
      return Container();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);
}
