import 'package:FilmFlu/constants.dart';
import 'package:FilmFlu/dto/person.dart';
import 'package:FilmFlu/network/client_api.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
      isLightsOn: true,
      containerChild: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<Person>(
          future: Api().fetchPerson(widget.actorId),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              Person person = snapshot.requireData;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "$personImgBaseUrl${person.profilePath}",
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          width: MediaQuery.of(context).size.width / 4,
                          child: AutoSizeText(person.biography,
                              maxFontSize: 16,
                              maxLines: 15,
                              minFontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ),
    );
  }
}
