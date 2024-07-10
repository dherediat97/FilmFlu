import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/presentation/widgets/default_circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class FilmWorkerItem extends StatefulWidget {
  const FilmWorkerItem({
    super.key,
    required this.index,
    required this.crew,
  });

  final int index;
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
      child: Column(
        children: [
          InkWell(
            onTap: () {
              AppConstants.personId = filmWorker.id;
              context.push('/personDetails/${filmWorker.id}');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Image.network(
                  '${AppUrls.personImgBaseUrl}${filmWorker.profilePath}',
                  height: 160,
                  width: 150,
                  fit: BoxFit.cover, loadingBuilder: (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                return DefaultCircularLoader(
                  loadingProgress: loadingProgress,
                  child: child,
                );
              }, errorBuilder: (context, url, error) {
                if (filmWorker.gender == 2) {
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
              }),
            ),
          ),
          AutoSizeText(
            filmWorker.name!,
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
          AutoSizeText(
            '${context.localizations.production_job} ${filmWorker.job} ${context.localizations.in_preposition} ${filmWorker.knownForDepartment}',
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'YsabeauInfant',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
