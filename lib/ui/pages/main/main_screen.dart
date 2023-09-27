//Core Packages
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
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
      containerChild: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  AppLocalizations.of(context)!.film_list_title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'YsabeauInfant',
                      fontSize: 40),
                )),
            Expanded(
              child: Container(
                child: FutureBuilder<List<Movie>>(
                  future: Api().fetchPopularMovies("day"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting) {
                      return MovieList(movies: snapshot.requireData);
                    } else {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
