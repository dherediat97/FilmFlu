import 'package:FilmFlu/dto/credits.dart';
import 'package:FilmFlu/dto/film_worker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:FilmFlu/dto/actor.dart';
import 'package:FilmFlu/network/api.dart';

class FilmCast extends StatefulWidget {
  const FilmCast({super.key, required this.movieId, required this.isCast});

  final bool isCast;

  final int movieId;

  @override
  State<FilmCast> createState() => _FilmCastState();
}

class _FilmCastState extends State<FilmCast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Credits>(
          future: Api().fetchCredits(widget.movieId),
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              final List<Actor>? cast = snapshot.requireData.cast;
              final List<FilmWorker>? crew = snapshot.requireData.crew;
              return GridView.custom(
                controller: TrackingScrollController(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 175,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 40,
                  mainAxisExtent: 300,
                ),
                childrenDelegate: SliverChildBuilderDelegate((context, index) {
                  if (widget.isCast)
                    return _buildGridActors(context, index, cast!);
                  else
                    return _buildFilmWorker(context, index, crew!);
                }, childCount: widget.isCast ? cast?.length : crew?.length),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget _buildGridActors(BuildContext context, int index, List<Actor> cast) {
    Actor actor = cast[index];
    return GridTile(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32.0),
            child: CachedNetworkImage(
                imageUrl: '$personImgBaseUrl${actor.profilePath}',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) {
                  if (actor.gender == 2) {
                    return SvgPicture.asset(
                      "assets/icons/actor_icon.svg",
                      height: 180,
                      fit: BoxFit.cover,
                      width: 120,
                    );
                  } else {
                    return SvgPicture.asset(
                      "assets/icons/actress_icon.svg",
                      height: 180,
                      fit: BoxFit.cover,
                      width: 120,
                    );
                  }
                }),
          ),
          Text(actor.name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "ShadowsIntoLight",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20)),
          actor.character!.isNotEmpty
              ? Text(
                  "interpreta a ${actor.character}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "YsabeauInfant",
                    color: Colors.white,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _buildFilmWorker(
      BuildContext context, int index, List<FilmWorker> crew) {
    FilmWorker filmWorker = crew[index];

    return GridTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
              imageUrl: '$personImgBaseUrl${filmWorker.profilePath}',
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                if (filmWorker.gender == 2) {
                  return SvgPicture.asset(
                    "assets/icons/actor_icon.svg",
                    height: 180,
                    fit: BoxFit.cover,
                    width: 120,
                  );
                } else {
                  return SvgPicture.asset(
                    "assets/icons/actress_icon.svg",
                    height: 180,
                    fit: BoxFit.cover,
                    width: 120,
                  );
                }
              }),
          Text("${filmWorker.name!}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "YsabeauInfant",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          Text(
            "realizó el trabajo de ${filmWorker.job} en ${filmWorker.knownForDepartment}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "YsabeauInfant",
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
