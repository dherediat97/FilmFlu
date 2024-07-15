import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/di/top_bloc_providers.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/top_blocs/language_cubit.dart';
import 'package:film_flu/presentation/widgets/flip_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
  final today = DateTime.now();
  bool loveTapped = false;

  @override
  Widget build(BuildContext context) {
    context.read<LanguageCubit>().changeStartLang();

    return TopBlocProviders(
      child: Scaffold(
        floatingActionButtonLocation: widget.fabLocation,
        resizeToAvoidBottomInset: true,
        appBar: !widget.fullScreenMode
            ? AppBar(
                leadingWidth: 100,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                      child: Image.asset(
                        AppAssets.logoIcon,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.push(AppRoutePaths.startRoute);
                        }
                      }),
                ),
                toolbarHeight: 75,
                elevation: 60,
                scrolledUnderElevation: 1,
                backgroundColor: Theme.of(context).colorScheme.primary,
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
        body: SafeArea(child: widget.child),
        bottomNavigationBar: !widget.fullScreenMode
            ? BottomAppBar(
                height: 50,
                padding: EdgeInsets.zero,
                color: Theme.of(context).colorScheme.primary,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  context.localizations.made_with_love,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  loveTapped = !loveTapped;
                                });
                              },
                              child: FlipCard(
                                toggler: !loveTapped,
                                frontCard: SvgPicture.asset(
                                  AppAssets.fullHeartIcon,
                                  height: 24,
                                  width: 24,
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.onPrimary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                backCard: SvgPicture.asset(
                                  AppAssets.fullHeartIcon,
                                  height: 24,
                                  width: 24,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.andalucianColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.copyright,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '${today.year} @dherediat97',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : null,
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }

  List<Widget> _appBarActions(BuildContext context) {
    List<Widget> actions = [];

    actions.add(
      IconButton(
        icon: const Icon(
          Icons.settings,
          color: Colors.white,
        ),
        onPressed: () {
          context.go(AppRoutePaths.settingsRoute);
        },
      ),
    );

    actions.add(DropdownButton<Locale>(
        onChanged: (language) {
          context
              .read<LanguageCubit>()
              .changeLang(context, language?.toString() ?? 'es');
          context.push(AppRoutePaths.startRoute);
        },
        dropdownColor: Colors.black,
        value: context.read<LanguageCubit>().state,
        underline: const SizedBox(),
        items: AppLocalizations.supportedLocales
            .map<DropdownMenuItem<Locale>>((Locale language) {
          return DropdownMenuItem<Locale>(
            value: language,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/flags/${language.languageCode}_flag.svg',
                  height: 20,
                  width: 20,
                ),
                Text(
                  language.languageCode,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          );
        }).toList()));
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
    //         color: Theme.of(context).colorScheme.primary,
    //       ),
    //     ),
    //   );
    // }
    return actions;
  }
}
