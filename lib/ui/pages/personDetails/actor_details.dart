//Core Packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/constants.dart';
import 'package:FilmFlu/dto/credit_person.dart';
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
          padding: EdgeInsets.all(16),
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        "$personImgBaseUrl${person.profilePath}",
                        fit: BoxFit.fitHeight,
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(person.name,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(person.biography,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                      FutureBuilder(
                        future: Api().fetchPersonCredits(widget.actorId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          } else {
                            var creditsList = snapshot.requireData;
                            return GridView.builder(
                              itemCount: creditsList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 200,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                              ),
                              itemBuilder: (context, index) {
                                CreditPerson filmPerson = creditsList[index];
                                debugPrint(filmPerson.toJson().toString());
                                return Row(
                                  children: [
                                    Image.network(
                                        "$movieImgBaseURL${filmPerson.backdropPath}"),
                                    Text(
                                      "${AppLocalizations.of(context)?.actor_job} ${filmPerson.character}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
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
