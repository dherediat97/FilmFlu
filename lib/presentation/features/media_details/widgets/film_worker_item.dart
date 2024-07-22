import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/domain/models/genre_entity.dart';
import 'package:film_flu/presentation/widgets/default_circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class FilmWorkerItem extends StatefulWidget {
  const FilmWorkerItem({
    super.key,
    required this.mainGenre,
    required this.index,
    required this.crew,
  });

  final int index;
  final GenreEntity mainGenre;
  final List<FilmWorkerEntity> crew;

  @override
  State<FilmWorkerItem> createState() => _FilmWorkerItemState();
}

class _FilmWorkerItemState extends State<FilmWorkerItem> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    List<FilmWorkerEntity> crew = widget.crew;
    FilmWorkerEntity filmWorker = crew[index];

    return GridTile(
      header: IconButton(
        onPressed: () {
          AppConstants.personId = filmWorker.id;
          context.push('${AppRoutePaths.personDetailsRoute}/${filmWorker.id}');
        },
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(32.0),
          child: Image.network(
            '${AppUrls.personImgBaseUrl}${filmWorker.profilePath}',
            height: 160,
            width: 150,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, loadingProgress) =>
                DefaultCircularLoader(progress: loadingProgress, child: child),
            errorBuilder: (context, url, error) {
              if (filmWorker.gender == 2) {
                return SvgPicture.asset(
                  widget.mainGenre.id == 16
                      ? AppAssets.animeActorImageIcon
                      : AppAssets.actorImageIcon,
                  height: 160,
                  width: 150,
                  fit: BoxFit.cover,
                );
              } else {
                return SvgPicture.asset(
                  widget.mainGenre.id == 16
                      ? AppAssets.animeActressImageIcon
                      : AppAssets.actressImageIcon,
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
            filmWorker.originalName!,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          AutoSizeText(
            '${context.localizations.production_job} ${filmWorker.job} ${context.localizations.in_preposition} ${filmWorker.knownForDepartment}',
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      child: Container(),
    );
  }
}
