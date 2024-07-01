import 'package:FilmFlu/app/constants/app_constants.dart';
import 'package:FilmFlu/app/di/top_bloc_providers.dart';
import 'package:FilmFlu/app/extensions/localizations_extensions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ScaffoldPage extends StatefulWidget {
  ScaffoldPage({
    super.key,
    required this.containerChild,
    this.floatingActionButton,
    this.isLightsOn,
    required this.isSearchVisible,
    this.fabLocation,
  });

  bool? isLightsOn = false;
  bool isSearchVisible = true;
  Widget? floatingActionButton;
  FloatingActionButtonLocation? fabLocation =
      FloatingActionButtonLocation.endTop;
  final Widget containerChild;

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  // final TextEditingController _searchController = TextEditingController();
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TopBlocProviders(
      child: Scaffold(
          floatingActionButtonLocation: widget.fabLocation,
          resizeToAvoidBottomInset: true,
          appBar: widget.isLightsOn == true
              ? AppBar(
                  leadingWidth: 60,
                  leading: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                        child: Image.asset(
                          'assets/images/transparent_logo.png',
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                        ),
                        onTap: () {
                          if (Navigator.canPop(context)) {
                            context.pop();
                          } else {
                            context.pushReplacementNamed('/');
                          }
                        }),
                  ),
                  toolbarHeight: 100,
                  centerTitle: true,
                  title: AutoSizeText(context.localizations.app_name,
                      minFontSize: 40,
                      maxFontSize: 80,
                      style: TextStyle(
                          fontFamily: 'YsabeauInfant',
                          color:
                              Theme.of(context).colorScheme.primaryContainer)),
                  elevation: 60,
                  scrolledUnderElevation: 1,
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                  actions: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: _appBarActions(context),
                        ),
                      )
                    ])
              : null,
          body: SafeArea(child: widget.containerChild),
          bottomNavigationBar: widget.isLightsOn == true
              ? BottomAppBar(
                  height: 50,
                  padding: EdgeInsets.zero,
                  surfaceTintColor: Colors.white,
                  child: SizedBox(
                    height: 50,
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(children: [
                              Text('Made with much',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.favorite, color: Colors.red),
                            ]),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(children: [
                              const Icon(Icons.copyright, color: Colors.black),
                              Center(
                                child: Text('${today.year} @dherediat97',
                                    style: const TextStyle(fontSize: 14)),
                              )
                            ]),
                          )
                        ]),
                  ),
                )
              : null,
          floatingActionButton: widget.floatingActionButton),
    );
  }

  List<Widget> _appBarActions(BuildContext context) {
    List<Widget> actions = [];
    Locale _locale;

    // actions.add(DropdownButton<Language>(
    //     onChanged: (Language? language) async {
    //       if (language != null) {
    //         _locale = await setLocale(language.languageCode);
    //         FilmFlu.setLocale(context, _locale);
    //         setState(() {});
    //       }
    //     },
    //     dropdownColor: Colors.black,
    //     icon: FutureBuilder<Locale>(
    //         future: getLocale(),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.waiting)
    //             return Container();

    //           return SvgPicture.asset(
    //             "assets/icons/flags/${snapshot.requireData.countryCode}_flag.svg",
    //             height: 20,
    //             width: 20,
    //           );
    //         }),
    //     underline: const SizedBox(),
    //     items: Language.languageList()
    //         .map<DropdownMenuItem<Language>>((Language language) {
    //       return DropdownMenuItem<Language>(
    //         value: language,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             SvgPicture.asset(
    //               "assets/icons/flags/${language.languageCode}_flag.svg",
    //               height: 20,
    //               width: 20,
    //             ),
    //             Text(
    //               language.name,
    //               style: TextStyle(color: Colors.white),
    //             )
    //           ],
    //         ),
    //       );
    //     }).toList()));
    if (kIsWeb) {
      actions.add(IconButton(
        onPressed: () async {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          AppConstants.version = packageInfo.version;
          //Descargar App Android
          final Uri url = Uri.parse(AppConstants.appDownloadBaseUrl);
          // launchUrl(url);
        },
        icon: Icon(
          Icons.android,
          color: Theme.of(context).colorScheme.primary,
        ),
      ));
    }
    if (widget.isSearchVisible) {
      actions.add(IconButton(
        onPressed: () => context.pushReplacementNamed('/settings/'),
        icon: Icon(
          Icons.settings,
          color: Theme.of(context).colorScheme.primary,
        ),
      ));
    }
    return actions;
  }
}
