import 'package:FilmFlu/dto/film_worker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:FilmFlu/dto/actor.dart';
import 'package:FilmFlu/network/api.dart';

class FilmCast extends StatelessWidget {
  const FilmCast({super.key, required this.cast, required this.crew});

  final List<Actor> cast;
  final List<FilmWorker> crew;

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          if (cast.isNotEmpty)
            return _buildGridActors(context, index);
          else
            return _buildFilmWorker(context, index);
        },
        childCount: cast.isNotEmpty ? cast.length : crew.length,
      ),
      shrinkWrap: true,
    );
  }

  Widget _buildGridActors(BuildContext context, int index) {
    Actor actor = cast[index];
    return GridTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
              imageUrl: '$personImgBaseUrl${actor.profilePath}',
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
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
          Text("${actor.name!}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Barlow",
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          Text(
            "es ${actor.character}",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Barlow"),
          ),
        ],
      ),
    );
  }

  Widget _buildFilmWorker(BuildContext context, int index) {
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
                  fontFamily: "Barlow",
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          Text(
            "realizó el trabajo de ${filmWorker.job} en ${filmWorker.knownForDepartment}",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Barlow"),
          ),
        ],
      ),
    );
  }
}
