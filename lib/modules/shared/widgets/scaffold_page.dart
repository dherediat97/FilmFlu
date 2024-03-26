//Core Packages
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_modular/flutter_modular.dart';

//My Packages
import 'package:FilmFlu/core/constants/constants.dart';
import 'package:FilmFlu/core/constants/language.dart';
import 'package:FilmFlu/main.dart';
import 'package:FilmFlu/modules/shared/drivers/local_storage/local_storage_service.dart';

// ignore: must_be_immutable
class ScaffoldPage extends StatefulWidget {
  ScaffoldPage(
      {super.key,
      required this.containerChild,
      this.floatingActionButton,
      this.isLightsOn,
      required this.isSearchVisible,
      this.fabLocation});

  bool? isLightsOn = false;
  bool isSearchVisible = true;
  Widget? floatingActionButton = null;
  FloatingActionButtonLocation? fabLocation =
      FloatingActionButtonLocation.endTop;
  final Widget containerChild;

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  // final TextEditingController _searchController = TextEditingController();
  final today = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        if (Navigator.canPop(context))
                          Navigator.pop(context);
                        else
                          Navigator.pushReplacementNamed(context, "/FilmFlu");
                      }),
                ),
                toolbarHeight: 100,
                centerTitle: true,
                title: AutoSizeText("Film Flu",
                    minFontSize: 40,
                    maxFontSize: 80,
                    style: TextStyle(
                        fontFamily: "YsabeauInfant",
                        color: Theme.of(context).colorScheme.primaryContainer)),
                elevation: 60,
                scrolledUnderElevation: 1,
                backgroundColor: Theme.of(context).colorScheme.onBackground,
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
                child: Container(
                  height: 50,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(children: [
                            Text("Made with much",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Icon(Icons.favorite, color: Colors.red),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(children: [
                            Icon(Icons.copyright, color: Colors.black),
                            Center(
                              child: Text("${today.year} @dherediat97",
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
    Locale _locale;
    getLocale().then((value) => _locale = value);

    actions.add(DropdownButton<Language>(
        onChanged: (Language? language) async {
          if (language != null) {
            _locale = await setLocale(language.languageCode);
            FilmFlu.setLocale(context, _locale);
            setState(() {});
          }
        },
        dropdownColor: Colors.black,
        icon: FutureBuilder<Locale>(
            future: getLocale(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Container();

              return SvgPicture.asset(
                "assets/icons/flags/${snapshot.requireData.countryCode}_flag.svg",
                height: 20,
                width: 20,
              );
            }),
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
}
