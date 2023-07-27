//Core Packages
import 'package:FilmFlu/network/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Api().fetchPopularMovies("day").then((value) {
      movies = value;
      setState(() {});
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
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextField(
                        autocorrect: true,
                        controller: _searchController,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Barlow"),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.search_film_hint,
                            hintStyle: TextStyle(
                                color: Colors.white54, fontFamily: "Barlow"),
                            icon: Icon(
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
                        fontFamily: 'Barlow',
                        fontSize: 40),
                  ))
            ]),
            MovieList(items: movies)
          ])),
    );
  }

  List<Widget> _appBarActions() {
    List<Widget> actions = [];
    // List<String> languages = [];
    // String languageChosen =
    //     "assets/icons/${Localizations.localeOf(context).languageCode}.svg";
    // for (var locale in MaterialApp().supportedLocales) {
    //   languages.add(locale.languageCode);
    // }

    // actions.add(DropdownButton(
    //     onChanged: (value) {
    //       languageChosen = languages[value];
    //     },
    //     icon: SvgPicture.asset(languageChosen),
    //     value: 0,
    //     items: [DropdownMenuItem(child: Container())]));
    if (kIsWeb) {
      actions.add(IconButton(
        onPressed: () async {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          //Descargar App Android
          final Uri url = Uri.parse(
              'https://github.com/dherediat97/Filmflu/releases/download/${packageInfo.version}/app-release.apk');
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
    // actions.add(IconButton(
    //   onPressed: () => Navigator.pushNamed(context, '/login'),
    //   icon: Icon(
    //     Icons.login,
    //     color: Theme.of(context).colorScheme.primary,
    //   ),
    // ));
    // } else {
    //   actions.add(IconButton(
    //     onPressed: () {},
    //     icon: Icon(
    //       Icons.more_vert,
    //       color: Theme.of(context).colorScheme.primary,
    //     ),
    //   ));
    // }
    return actions;
  }
}
