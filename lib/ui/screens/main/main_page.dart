//Core Packages
import 'package:FilmFlu/network/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/ui/components/movie_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Movie> movies = [];
  final now = new DateTime.now();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Api().fetchPopularMovies("day").then((value) {
      setState(() {
        movies = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
          toolbarHeight: 75,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Center(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextField(
                        autocorrect: true,
                        controller: _searchController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20,
                            fontFamily: "YsabeauInfant"),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.search_film_hint,
                            hintStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: 20,
                                fontFamily: "YsabeauInfant"),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            border: InputBorder.none),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          title: Image.asset('assets/images/transparent_logo.png', height: 60),
          elevation: 48,
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: _appBarActions(),
              ),
            )
          ]),
      body: Container(
          color: Theme.of(context).colorScheme.background,
          child: ListView(children: [
            Row(children: [
              Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    AppLocalizations.of(context)!.film_list_title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'YsabeauInfant',
                        fontSize: 40),
                  ))
            ]),
            MovieList(items: movies),
          ])),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        height: 50.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Made with many",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            Icon(Icons.favorite, color: Colors.red),
            Spacer(flex: 1),
            Icon(Icons.copyright, color: Colors.black),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("${now.year} @dherediat97 All Rights Reserved",
                  style: TextStyle(fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _appBarActions() {
    List<Widget> actions = [];
    List<String> languages = [];
    String languageChosen = Localizations.localeOf(context).languageCode;
    for (var locale in MaterialApp().supportedLocales) {
      languages.add("assets/icons/${locale.languageCode}_flag.svg");
    }

    // actions.add(DropdownButton<String>(
    //     onChanged: (value) {
    //       setState(() {
    //         languageChosen = value!;
    //       });
    //     },
    //     icon: SvgPicture.asset(languageChosen),
    //     value: languages.first,
    //     items: languages.map<DropdownMenuItem<String>>((String value) {
    //       return DropdownMenuItem<String>(
    //         value: value,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             SvgPicture.asset(value),
    //           ],
    //         ),
    //       );
    //     }).toList()));
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
    } else {
      actions.add(IconButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        icon: Icon(
          Icons.login,
          color: Theme.of(context).colorScheme.primary,
        ),
      ));
    }
    return actions;
  }
}
