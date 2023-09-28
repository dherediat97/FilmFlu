//Core Packages
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//My Packages
import 'package:FilmFlu/constants.dart';
import 'package:FilmFlu/dto/credit_person.dart';
import 'package:FilmFlu/ui/util/utilDate.dart';
import 'package:FilmFlu/dto/person.dart';
import 'package:FilmFlu/network/client_api.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';

class ActorDetailsPage extends StatefulWidget {
  const ActorDetailsPage({super.key, required this.actorId});

  final int actorId;

  @override
  State<ActorDetailsPage> createState() => _ActorDetailsPage();
}

class _ActorDetailsPage extends State<ActorDetailsPage> {
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                Row(
                                  children: [
                                    Icon(
                                      Icons.public,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child:
                                          AutoSizeText("${person.placeOfBirth}",
                                              maxFontSize: 16,
                                              minFontSize: 13,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                              )),
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
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                            FutureBuilder<List<CreditPerson>>(
                              future: Api().fetchPersonCredits(widget.actorId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                        ConnectionState.waiting &&
                                    snapshot.hasData) {
                                  List<CreditPerson> creditsList =
                                      snapshot.requireData;
                                  return GridView.builder(
                                    controller: TrackingScrollController(),
                                    itemCount: creditsList.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 150,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 40,
                                      mainAxisExtent: 340,
                                      childAspectRatio: MediaQuery.of(context)
                                          .size
                                          .aspectRatio,
                                    ),
                                    itemBuilder: (context, index) {
                                      CreditPerson filmPerson =
                                          creditsList[index];
                                      return GridTile(
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              child: Image.network(
                                                filmPerson.backdropPath == null
                                                    ? "$personImgBaseUrl${filmPerson.posterPath}"
                                                    : "$personImgBaseUrl${filmPerson.backdropPath}",
                                                height: 220,
                                                width: 150,
                                                fit: BoxFit.cover,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
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
                                                // errorBuilder:
                                                //     (context, url, error) {
                                                //   return SvgPicture.asset(
                                                //     "assets/icons/placeholder_image.svg",
                                                //     height: 220,
                                                //     fit: BoxFit.cover,
                                                //     width: 150,
                                                //   );
                                                // },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0),
                                              child: Text(
                                                "${AppLocalizations.of(context)?.actor_job} ${filmPerson.character}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
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
                            ),
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
