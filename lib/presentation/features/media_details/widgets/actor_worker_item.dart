import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/presentation/widgets/default_circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class FilmActorItem extends StatefulWidget {
  const FilmActorItem({
    super.key,
    required this.index,
    required this.cast,
  });

  final int index;
  final List<ActorEntity> cast;

  @override
  State<FilmActorItem> createState() => _FilmActorItemState();
}

class _FilmActorItemState extends State<FilmActorItem> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    List<ActorEntity> cast = widget.cast;
    ActorEntity actor = cast[index];

    return GridTile(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              AppConstants.personId = actor.id;
              context.push('/personDetails/${actor.id}');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Image.network(
                '${AppUrls.personImgBaseUrl}${actor.profilePath}',
                height: 160,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) =>
                    DefaultCircularLoader(
                  loadingProgress: loadingProgress,
                  child: child,
                ),
                errorBuilder: (context, url, error) {
                  if (actor.gender == 2) {
                    return SvgPicture.asset(
                      'assets/icons/actor_icon.svg',
                      height: 160,
                      fit: BoxFit.cover,
                      width: 150,
                    );
                  } else {
                    return SvgPicture.asset(
                      'assets/icons/actress_icon.svg',
                      height: 160,
                      fit: BoxFit.cover,
                      width: 150,
                    );
                  }
                },
              ),
            ),
          ),
          AutoSizeText(
            actor.name!,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'ShadowsIntoLight',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
            ),
          ),
          actor.character!.isNotEmpty || actor.character != null
              ? AutoSizeText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  '${context.localizations.actor_job} ${actor.character}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'YsabeauInfant',
                    color: Colors.white,
                  ),
                )
              : const Text('Desconocido')
        ],
      ),
    );
  }
}
