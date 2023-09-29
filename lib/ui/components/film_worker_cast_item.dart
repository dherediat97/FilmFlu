import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:FilmFlu/constants.dart';
import 'package:FilmFlu/dto/film_worker.dart';
import 'package:FilmFlu/ui/pages/personDetails/actor_details.dart';

class FilmWorkerItem extends StatefulWidget {
  FilmWorkerItem({super.key, required this.index, required this.crew});
  int index;
  List<FilmWorker> crew;

  @override
  State<FilmWorkerItem> createState() => _FilmWorkerItemState();
}

class _FilmWorkerItemState extends State<FilmWorkerItem> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    List<FilmWorker> crew = widget.crew;
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
                  height: 160,
                  width: 150,
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
                    height: 160,
                    fit: BoxFit.cover,
                    width: 150,
                  );
                } else {
                  return SvgPicture.asset(
                    "assets/icons/actress_icon.svg",
                    height: 160,
                    fit: BoxFit.cover,
                    width: 150,
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
