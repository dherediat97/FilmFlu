//Core Packages
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//My Packages
import 'package:FilmFlu/modules/movies/domain/entities/media_item.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_list/movie_list.dart';
import 'package:FilmFlu/core/extensions/loading_extension.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_api.dart';
import 'package:FilmFlu/modules/shared/widgets/scaffold_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _moviesScrollController = ScrollController();
  final _tvSeriesScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      isSearchVisible: true,
      fabLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Container(
            width: 100,
            height: 100,
            child: Icon(
              Icons.search,
              size: 24,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primaryContainer,
                ])),
          ),
        ),
        backgroundColor: Colors.transparent,
        onPressed: () {},
      ),
      isLightsOn: true,
      containerChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                AppLocalizations.of(context)!.film_list_title,
                maxFontSize: 30,
                minFontSize: 20,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  child: FutureBuilder<List<MediaItem>>(
                    future: Api().fetchPopularMediaTypes("day", "movie"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return DefaultWidgetLoading();
                      return Scrollbar(
                          thickness: 3,
                          controller: _moviesScrollController,
                          child: MovieList(
                              items: snapshot.requireData,
                              scrollController: _moviesScrollController));
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              AutoSizeText(
                AppLocalizations.of(context)!.tv_series_list_title,
                maxFontSize: 30,
                minFontSize: 20,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  child: FutureBuilder<List<MediaItem>>(
                    future: Api().fetchPopularMediaTypes("day", "tv"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return DefaultWidgetLoading();
                      return Scrollbar(
                          thickness: 3,
                          controller: _tvSeriesScrollController,
                          child: MovieList(
                            items: snapshot.requireData,
                            scrollController: _tvSeriesScrollController,
                          ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
