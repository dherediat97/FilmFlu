//Core Packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//My Packages
import 'package:FilmFlu/dto/credits.dart';
import 'package:FilmFlu/dto/film_worker.dart';
import 'package:FilmFlu/dto/actor.dart';
import 'package:FilmFlu/network/client_api.dart';
import 'package:FilmFlu/constants.dart';

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
      padding: EdgeInsets.all(8),
      child: FutureBuilder<Credits>(
          future: Api().fetchCredits(widget.movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              if (snapshot.data != null) {
                final List<Actor>? cast = snapshot.data!.cast;
                final List<FilmWorker>? crew = snapshot.data!.crew;
                return GridView.builder(
                  controller: TrackingScrollController(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    mainAxisExtent: 275,
                    childAspectRatio: MediaQuery.of(context).size.aspectRatio,
                  ),
                  itemCount: widget.isCast ? cast?.length : crew?.length,
                  itemBuilder: (context, index) => widget.isCast
                      ? _buildGridActors(context, index, cast!)
                      : _buildFilmWorker(context, index, crew!),
                );
              } else {
                return Container();
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget _buildGridActors(BuildContext context, int index, List<Actor> cast) {
    Actor actor = cast[index];
    // cast.map((element) => element.id == actor.id);
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
                  if (actor.profilePath == null || actor.gender == 2) {
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
                  fontSize: 18)),
          actor.character!.isNotEmpty
              ? Text(
                  "${AppLocalizations.of(context)?.actor_job} ${actor.character}",
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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32.0),
            child: CachedNetworkImage(
                imageUrl: '$personImgBaseUrl${filmWorker.profilePath}',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) {
                  if (filmWorker.profilePath == null ||
                      filmWorker.gender == 2) {
                    return SvgPicture.asset(
                      "assets/icons/actor_icon.svg",
                      height: 180,
                      fit: BoxFit.cover,
                      width: 120,
                    );
                  } else if (filmWorker.profilePath == null ||
                      filmWorker.gender != 2) {
                    return SvgPicture.asset(
                      "assets/icons/actress_icon.svg",
                      height: 180,
                      fit: BoxFit.cover,
                      width: 120,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
          Text(filmWorker.name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "ShadowsIntoLight",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18)),
          Text(
            "${AppLocalizations.of(context)?.production_job} ${filmWorker.job} ${AppLocalizations.of(context)?.in_preposition} ${filmWorker.knownForDepartment}",
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
