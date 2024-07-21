import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/domain/models/genre_entity.dart';
import 'package:film_flu/presentation/widgets/default_circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class FilmActorItem extends StatefulWidget {
  const FilmActorItem({
    super.key,
    required this.mainGenre,
    required this.index,
    required this.cast,
  });

  final int index;
  final GenreEntity mainGenre;
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
      header: IconButton(
        onPressed: () {
          AppConstants.personId = actor.id;
          context.push('${AppRoutePaths.personDetailsRoute}/${actor.id}');
        },
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(32.0),
          child: Image.network(
            '${AppUrls.personImgBaseUrl}${actor.profilePath}',
            height: 160,
            width: 150,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, progress) =>
                DefaultCircularLoader(progress: progress, child: child),
            errorBuilder: (context, url, error) {
              if (actor.gender == 2) {
                return SvgPicture.asset(
                  AppAssets.actorImageIcon,
                  height: 160,
                  width: 150,
                  fit: BoxFit.cover,
                );
              } else {
                return SvgPicture.asset(
                  AppAssets.actressImageIcon,
                  height: 160,
                  width: 150,
                  fit: BoxFit.cover,
                );
              }
            },
          ),
        ),
      ),
      footer: Column(
        children: [
          AutoSizeText(
            actor.originalName!,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          actor.character!.isNotEmpty || actor.character != null
              ? AutoSizeText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  '${context.localizations.actor_job} ${actor.character}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              : const Text('Desconocido')
        ],
      ),
      child: Container(),
    );
  }
}
