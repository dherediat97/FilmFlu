//Core Packages
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//My Packages
import 'package:FilmFlu/dto/credits.dart';
import 'package:FilmFlu/ui/pages/personDetails/actor_details.dart';
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()));
            }
            final List<Actor>? cast = snapshot.requireData.cast;
            final List<FilmWorker>? crew = snapshot.requireData.crew;
            return GridView.builder(
              controller: TrackingScrollController(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 0,
                crossAxisSpacing: 40,
                mainAxisExtent: 340,
                childAspectRatio: MediaQuery.of(context).size.aspectRatio,
              ),
              itemCount: widget.isCast ? cast?.length : crew?.length,
              itemBuilder: (context, index) => widget.isCast
                  ? _buildGridActors(context, index, cast!)
                  : _buildFilmWorker(context, index, crew!),
            );
          }),
    );
  }

  Widget _buildGridActors(BuildContext context, int index, List<Actor> cast) {
    Actor actor = cast[index];
    return GridTile(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ActorDetailsPage(actorId: actor.id)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Image.network('$personImgBaseUrl${actor.profilePath}',
                  fit: BoxFit.cover, loadingBuilder: (BuildContext context,
                      Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }, errorBuilder: (context, url, error) {
                if (actor.gender == 2) {
                  return SvgPicture.asset(
                    "assets/icons/actor_icon.svg",
                    height: 220,
                    fit: BoxFit.cover,
                    width: 120,
                  );
                } else {
                  return SvgPicture.asset(
                    "assets/icons/actress_icon.svg",
                    height: 220,
                    fit: BoxFit.cover,
                    width: 120,
                  );
                }
              }),
            ),
          ),
          AutoSizeText(actor.name!,
              textAlign: TextAlign.center,
              minFontSize: 16,
              stepGranularity: 1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: "ShadowsIntoLight",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18)),
          actor.character!.isNotEmpty
              ? AutoSizeText(
                  minFontSize: 14,
                  stepGranularity: 1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  "${AppLocalizations.of(context)?.actor_job} ${actor.character}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
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
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ActorDetailsPage(actorId: filmWorker.id)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Image.network('$personImgBaseUrl${filmWorker.profilePath}',
                  fit: BoxFit.cover, loadingBuilder: (BuildContext context,
                      Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }, errorBuilder: (context, url, error) {
                if (filmWorker.gender == 2) {
                  return SvgPicture.asset(
                    "assets/icons/actor_icon.svg",
                    height: 220,
                    fit: BoxFit.cover,
                    width: 120,
                  );
                } else {
                  return SvgPicture.asset(
                    "assets/icons/actress_icon.svg",
                    height: 220,
                    fit: BoxFit.cover,
                    width: 120,
                  );
                }
              }),
            ),
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
