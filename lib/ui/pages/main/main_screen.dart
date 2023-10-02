//Core Packages
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//My Packages
import 'package:FilmFlu/dto/media_item.dart';
import 'package:FilmFlu/ui/components/movie_list.dart';
import 'package:FilmFlu/network/client_api.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      routeName: "",
      isSearchVisible: true,
      isLightsOn: true,
      containerChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.film_list_title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'YsabeauInfant',
                  fontSize: 30),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                child: FutureBuilder<List<MediaItem>>(
                  future: Api().fetchPopularMediaTypes("day", "movie"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting) {
                      return MovieList(items: snapshot.requireData);
                    } else {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Novedades en Series",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'YsabeauInfant',
                  fontSize: 30),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                child: FutureBuilder<List<MediaItem>>(
                  future: Api().fetchPopularMediaTypes("day", "tv"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting) {
                      return MovieList(items: snapshot.requireData);
                    } else {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
