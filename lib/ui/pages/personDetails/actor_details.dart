//Core Packages
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/constants.dart';
import 'package:FilmFlu/dto/credit_person.dart';
import 'package:FilmFlu/ui/util/utilDate.dart';
import 'package:FilmFlu/dto/person.dart';
import 'package:FilmFlu/network/client_api.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';
import 'package:FilmFlu/dto/credits_person.dart';
import 'package:FilmFlu/ui/pages/movieDetails/movie_details.dart';
import 'package:FilmFlu/ui/theme/colors.dart';

class ActorDetailsPage extends StatefulWidget {
  const ActorDetailsPage({super.key, required this.actorId});

  final int actorId;

  @override
  State<ActorDetailsPage> createState() => _ActorDetailsPage();
}

class _ActorDetailsPage extends State<ActorDetailsPage> {
  bool isActorWorkSelected = true;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      routeName: "",
      isSearchVisible: true,
      isLightsOn: true,
      containerChild: SingleChildScrollView(
        controller: ScrollController(),
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(12),
          child: FutureBuilder<Person>(
              future: Api().fetchPerson(widget.actorId),
              builder: (context, snapshot) {
                Person? person = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: CircularProgressIndicator()));
                } else if (person != null) {
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
                                              Icons.abc,
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
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.public,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: SizedBox(
                                        width: 180,
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
                                  textAlign: TextAlign.justify,
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
                                      snapshot.data!.cast;
                                  List<CreditPerson>? creditsListAsProduction =
                                      snapshot.data?.crew;
                                  return isActorWorkSelected
                                      ? GridView.builder(
                                          controller:
                                              TrackingScrollController(),
                                          itemCount: creditsListAsActor.length,
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 150,
                                            mainAxisSpacing: 20,
                                            crossAxisSpacing: 40,
                                            mainAxisExtent: 340,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                    .size
                                                    .aspectRatio,
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
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            MovieDetailsPage(
                                                              isTrailerSelected:
                                                                  false,
                                                              movieId:
                                                                  filmPerson.id,
                                                              isFilm: true,
                                                            )));
                                              },
                                              child: GridTile(
                                                child: Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32.0),
                                                      child: Image.network(
                                                        filmPerson.backdropPath !=
                                                                null
                                                            ? "$personImgBaseUrl${filmPerson.backdropPath}"
                                                            : "$personImgBaseUrl${person.profilePath}",
                                                        height: 220,
                                                        width: 150,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent?
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return child;
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          );
                                                        },
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
                                      : GridView.builder(
                                          controller:
                                              TrackingScrollController(),
                                          itemCount:
                                              creditsListAsProduction?.length,
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 150,
                                            mainAxisSpacing: 20,
                                            crossAxisSpacing: 40,
                                            mainAxisExtent: 340,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                    .size
                                                    .aspectRatio,
                                          ),
                                          itemBuilder: (context, index) {
                                            CreditPerson filmPerson =
                                                creditsListAsProduction![index];
                                            print(filmPerson);
                                            String? movieTitle = filmPerson
                                                        .title !=
                                                    null
                                                ? "${filmPerson.job} ${AppLocalizations.of(context)?.in_preposition} ${filmPerson.title}"
                                                : "${filmPerson.job}";
                                            return InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            MovieDetailsPage(
                                                              isTrailerSelected:
                                                                  false,
                                                              movieId:
                                                                  filmPerson.id,
                                                              isFilm: true,
                                                            )));
                                              },
                                              child: GridTile(
                                                child: Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32.0),
                                                      child: Image.network(
                                                        filmPerson.backdropPath !=
                                                                null
                                                            ? "$personImgBaseUrl${filmPerson.backdropPath}"
                                                            : "$personImgBaseUrl${person.profilePath}",
                                                        height: 220,
                                                        width: 150,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent?
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return child;
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16.0),
                                                      child: AutoSizeText(
                                                        "${AppLocalizations.of(context)?.production_job} $movieTitle",
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
                                          });
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
                } else {
                  return Container();
                }
              }),
        ),
      ),
    );
  }
}
