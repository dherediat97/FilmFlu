//Core Packages
import 'package:FilmFlu/modules/movies/domain/entities/detailsMovieArguments.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/core/constants/constants.dart';
import 'package:FilmFlu/dto/credit_person.dart';
import 'package:FilmFlu/core/utils/utilDate.dart';
import 'package:FilmFlu/dto/person.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_api.dart';
import 'package:FilmFlu/modules/shared/widgets/scaffold_page.dart';
import 'package:FilmFlu/dto/credits_person.dart';
import 'package:FilmFlu/core/constants/theme/colors.dart';
import 'package:FilmFlu/core/extensions/loading_extension.dart';

class PersonDetailsPage extends StatefulWidget {
  const PersonDetailsPage({super.key, required this.actorId});

  final String actorId;

  @override
  State<PersonDetailsPage> createState() => _PersonDetailsPagePage();
}

class _PersonDetailsPagePage extends State<PersonDetailsPage> {
  bool isActorWorkSelected = true;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      isSearchVisible: true,
      isLightsOn: true,
      containerChild: SingleChildScrollView(
        controller: ScrollController(),
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(8),
          child: FutureBuilder<Person>(
              future: Api().fetchPerson(widget.actorId),
              builder: (context, snapshot) {
                Person? person = snapshot.data;
                if (person == null) return Container();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return DefaultWidgetLoading();
                } else
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: Image.network(
                              "$personImgBaseUrl${person.profilePath}",
                              height: 150,
                              width: 100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(person.name,
                                    textAlign: TextAlign.start,
                                    maxFontSize: 26,
                                    minFontSize: 20,
                                    stepGranularity: 1,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: "ShadowsIntoLight",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.celebration,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                            "${parseDate(person.birthday)}",
                                            textAlign: TextAlign.start,
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                                person.deathday != null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Symbols.skull,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                  "${parseDate(person.deathday!)}",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.public,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: SizedBox(
                                        width: 220,
                                        child: AutoSizeText(
                                            "${person.placeOfBirth.trim()}",
                                            maxFontSize: 20,
                                            minFontSize: 15,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(person.biography,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Papeles que ha realizado",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 32.0),
                                child: SegmentedButton<bool>(
                                  selectedIcon: null,
                                  emptySelectionAllowed: false,
                                  showSelectedIcon: false,
                                  selected: <bool>{isActorWorkSelected},
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return primaryColor;
                                        }
                                        return Colors.white24;
                                      },
                                    ),
                                  ),
                                  segments: [
                                    ButtonSegment<bool>(
                                      label: Text(
                                        AppLocalizations.of(context)!
                                            .character_cast,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      value: true,
                                    ),
                                    ButtonSegment<bool>(
                                      label: Text(
                                        AppLocalizations.of(context)!
                                            .production_cast,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      value: false,
                                    ),
                                  ],
                                  onSelectionChanged: (Set<bool> newSelection) {
                                    setState(() {
                                      isActorWorkSelected = newSelection.first;
                                    });
                                  },
                                ),
                              ),
                            ),
                            FutureBuilder<CreditsPerson>(
                              future: Api().fetchPersonCredits(widget.actorId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                        ConnectionState.waiting &&
                                    snapshot.hasData) {
                                  List<CreditPerson> creditsListAsActor =
                                      snapshot
                                          .data!.cast
                                          .where((element) =>
                                              element.character != null)
                                          .where((element) =>
                                              element.title != null)
                                          .toList();
                                  List<CreditPerson>? creditsListAsProduction =
                                      snapshot.data?.crew!
                                          .where(
                                              (element) => element.job != null)
                                          .where((element) =>
                                              element.title != null)
                                          .toList();
                                  return isActorWorkSelected
                                      ? GridView.builder(
                                          controller:
                                              TrackingScrollController(),
                                          itemCount: creditsListAsActor.length,
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 40,
                                            crossAxisSpacing: 60,
                                            mainAxisExtent: 420,
                                          ),
                                          itemBuilder: (context, index) {
                                            CreditPerson filmPerson =
                                                creditsListAsActor[index];
                                            String? movieTitle = filmPerson
                                                        .title !=
                                                    null
                                                ? "${filmPerson.character} ${AppLocalizations.of(context)?.in_preposition} ${filmPerson.title}"
                                                : "${filmPerson.character}";
                                            return InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                    context, "/movieDetails",
                                                    arguments:
                                                        DetailsMovieArguments(
                                                            movieId: filmPerson
                                                                .id
                                                                .toString(),
                                                            mediaType:
                                                                "movie"));
                                              },
                                              child: GridTile(
                                                child: Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32),
                                                      child: Image.network(
                                                        filmPerson.backdropPath !=
                                                                null
                                                            ? "$personImgBaseUrl${filmPerson.backdropPath}"
                                                            : "$personImgBaseUrl${person.profilePath}",
                                                        width: 250,
                                                        height: 320,
                                                        loadingBuilder: (context,
                                                                child,
                                                                loadingProgress) =>
                                                            DefaultAsyncLoading(
                                                          child: child,
                                                          loadingProgress:
                                                              loadingProgress,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16.0),
                                                      child: AutoSizeText(
                                                        "${AppLocalizations.of(context)?.actor_job} $movieTitle",
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 3,
                                                        minFontSize: 14,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : LazyLoadScrollView(
                                          onEndOfPage: () {},
                                          child: GridView.builder(
                                              controller:
                                                  TrackingScrollController(),
                                              itemCount: creditsListAsProduction
                                                  ?.length,
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 40,
                                                mainAxisExtent: 400,
                                              ),
                                              itemBuilder: (context, index) {
                                                CreditPerson filmPerson =
                                                    creditsListAsProduction![
                                                        index];
                                                String? movieTitle = filmPerson
                                                            .title !=
                                                        null
                                                    ? "${filmPerson.job} ${AppLocalizations.of(context)?.in_preposition} ${filmPerson.title}"
                                                    : "${filmPerson.job}";
                                                return InkWell(
                                                  onTap: () {
                                                    Modular.to.pushReplacementNamed(
                                                        "/movieDetails/${filmPerson.id}");
                                                  },
                                                  child: GridTile(
                                                    child: Column(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      32.0),
                                                          child: Image.network(
                                                            filmPerson.backdropPath !=
                                                                    null
                                                                ? "$personImgBaseUrl${filmPerson.backdropPath}"
                                                                : "$personImgBaseUrl${person.profilePath}",
                                                            width: 250,
                                                            height: 320,
                                                            loadingBuilder: (context,
                                                                    child,
                                                                    loadingProgress) =>
                                                                DefaultAsyncLoading(
                                                              child: child,
                                                              loadingProgress:
                                                                  loadingProgress,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 16.0),
                                                          child: AutoSizeText(
                                                            "${AppLocalizations.of(context)?.production_job} $movieTitle",
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 3,
                                                            minFontSize: 14,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        );
                                } else {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  );
              }),
        ),
      ),
    );
  }
}
