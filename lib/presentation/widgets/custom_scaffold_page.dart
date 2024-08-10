import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';
import 'package:film_flu/presentation/top_blocs/app/app_bloc.dart';
import 'package:film_flu/presentation/widgets/bottom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.fullScreenMode = false,
    this.isSearchVisible = true,
    this.fabLocation = FloatingActionButtonLocation.endTop,
  });

  final Widget child;
  final Widget? floatingActionButton;
  final bool fullScreenMode;
  final bool isSearchVisible;
  final FloatingActionButtonLocation fabLocation;

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().add(const AppEvent.changeStartLang());

    return Scaffold(
      floatingActionButtonLocation: widget.fabLocation,
      appBar: !widget.fullScreenMode
          ? AppBar(
              title: titleScaffold(),
              automaticallyImplyLeading: true,
              centerTitle: true,
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
                      context.pushReplacement(AppRoutePaths.startRoute);
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
            )
          : null,
      body: widget.child,
      bottomNavigationBar:
          !widget.fullScreenMode ? const MyBottomNavigationBar() : null,
      floatingActionButton: widget.floatingActionButton,
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
          context.pushReplacement(AppRoutePaths.startRoute);
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
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
          );
        }).toList()));
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

  Widget titleScaffold() {
    MediaType mediaTypeSelected =
        context.read<HomeBloc>().state.mediaTypeSelected;
    if (mediaTypeSelected == MediaType.movie) {
      return Text(context.localizations.movies);
    } else if (mediaTypeSelected == MediaType.tv) {
      return Text(context.localizations.series);
    } else {
      return const SearchBar();
    }
  }
}
