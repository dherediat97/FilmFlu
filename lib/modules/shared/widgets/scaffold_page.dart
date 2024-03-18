//Core Packages
import 'dart:async';
import 'package:FilmFlu/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_modular/flutter_modular.dart';

//My Packages
import 'package:FilmFlu/core/constants/constants.dart';
import 'package:FilmFlu/modules/movies/domain/entities/media_item.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_api.dart';
import 'package:FilmFlu/core/constants/language.dart';
import 'package:FilmFlu/modules/shared/drivers/local_storage/local_storage_service.dart';

// ignore: must_be_immutable
class ScaffoldPage extends StatefulWidget {
  ScaffoldPage(
      {super.key,
      required this.containerChild,
      this.floatingActionButton,
      this.isLightsOn,
      required this.isSearchVisible});

  bool? isLightsOn = false;
  bool isSearchVisible = true;
  Widget? floatingActionButton = null;
  final Widget containerChild;

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  final TextEditingController _searchController = TextEditingController();
  final today = new DateTime.now();
  Timer? _debounce;
  List<MediaItem> movieList = [];

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
                        Modular.to.navigate(Modular.initialRoute);
                      }),
                ),
                toolbarHeight: 100,
                centerTitle: true,
                flexibleSpace: Container(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 48, right: 48),
                      child: Center(
                          child: SafeArea(
                              child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.isSearchVisible == true
                              ? DropdownMenu<MediaItem>(
                                  dropdownMenuEntries: [
                                    DropdownMenuEntry(
                                        value: movieMock1,
                                        label: "El castillo ambulante")
                                  ],
                                  width: 200,
                                  controller: _searchController,
                                  leadingIcon: Icon(Icons.search,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  hintText:
                                      translation(context).search_film_hint,
                                  inputDecorationTheme: InputDecorationTheme(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 5.0)),
                                  onSelected: (MediaItem? movie) {
                                    Modular.to
                                        .navigate("/movieDetails/${movie?.id}");
                                  },
                                )
                              : Text(""),
                        ],
                      )))),
                ),
                elevation: 1,
                scrolledUnderElevation: 20,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                child: Container(
                  height: 50,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(children: [
                            Text("Made with much",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Icon(Icons.favorite, color: Colors.red),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(children: [
                            Icon(Icons.copyright, color: Colors.black),
                            Center(
                              child: Text(" ${today.year} @dherediat97",
                                  style: TextStyle(fontSize: 14)),
                            )
                          ]),
                        )
                      ]),
                ),
              )
            : null,
        floatingActionButton: widget.floatingActionButton);
  }

  List<Widget> _appBarActions(BuildContext context) {
    List<Widget> actions = [];
    String? countryCode = "es";
    Locale _locale;

    actions.add(DropdownButton<Language>(
        onChanged: (Language? language) async {
          if (language != null) {
            setState(() {});
            _locale = await setLocale(language.languageCode);
            FilmFlu.setLocale(context, _locale);
            countryCode = _locale.countryCode;
          }
        },
        dropdownColor: Colors.black,
        icon: SvgPicture.asset(
          "assets/icons/flags/${countryCode}_flag.svg",
          height: 20,
          width: 20,
        ),
        underline: const SizedBox(),
        items: Language.languageList()
            .map<DropdownMenuItem<Language>>((Language language) {
          return DropdownMenuItem<Language>(
            value: language,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  "assets/icons/flags/${language.languageCode}_flag.svg",
                  height: 20,
                  width: 20,
                ),
                Text(
                  language.name,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          );
        }).toList()));
    if (kIsWeb) {
      actions.add(IconButton(
        onPressed: () async {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          version = packageInfo.version;
          //Descargar App Android
          final Uri url = Uri.parse(appDownloadBaseUrl);
          launchUrl(url);
        },
        icon: Icon(
          Icons.android,
          color: Theme.of(context).colorScheme.primary,
        ),
      ));
    }
    if (widget.isSearchVisible) {
      actions.add(IconButton(
        onPressed: () => Modular.to.pushReplacementNamed("/settings/"),
        icon: Icon(
          Icons.settings,
          color: Theme.of(context).colorScheme.primary,
        ),
      ));
    }
    return actions;
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      Api().searchMovie(query).then((movies) {
        movieList = movies.toList();
      });
    });
  }
}
