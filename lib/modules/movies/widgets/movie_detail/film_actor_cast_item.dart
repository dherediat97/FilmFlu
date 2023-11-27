import 'package:FilmFlu/core/extensions/loading_extension.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:FilmFlu/core/constants/constants.dart';
import 'package:FilmFlu/dto/actor.dart';

class FilmActorItem extends StatefulWidget {
  FilmActorItem({super.key, required this.index, required this.cast});
  final int index;
  final List<Actor> cast;

  @override
  State<FilmActorItem> createState() => _FilmActorItemState();
}

class _FilmActorItemState extends State<FilmActorItem> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    List<Actor> cast = widget.cast;
    Actor actor = cast[index];
    return GridTile(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Modular.to.navigate("/personDetails/${actor.id.toInt()}");
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Image.network('$personImgBaseUrl${actor.profilePath}',
                  height: 160,
                  width: 150,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) =>
                      DefaultAsyncLoading(
                        child: child,
                        loadingProgress: loadingProgress,
                      ),
                  errorBuilder: (context, url, error) {
                    if (actor.gender == 2) {
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
          AutoSizeText(actor.name!,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: "ShadowsIntoLight",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18)),
          actor.character!.isNotEmpty || actor.character != null
              ? AutoSizeText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  "${AppLocalizations.of(context)?.actor_job} ${actor.character}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "YsabeauInfant",
                    color: Colors.white,
                  ),
                )
              : Text("Desconocido")
        ],
      ),
    );
  }
}
