import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:octo_image/octo_image.dart';

class FilmWorkerItem extends StatefulWidget {
  const FilmWorkerItem({
    super.key,
    required this.filmWorker,
  });

  final FilmWorkerEntity? filmWorker;

  @override
  State<FilmWorkerItem> createState() => _FilmWorkerItemState();
}

class _FilmWorkerItemState extends State<FilmWorkerItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        AppConstants.personId = widget.filmWorker!.id;
        context.push(
            '${AppRoutePaths.personDetailsRoute}/${widget.filmWorker?.id}');
      },
      title: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: OctoImage(
          image: CachedNetworkImageProvider(
            '${AppUrls.personImgBaseUrl}${widget.filmWorker?.profilePath}',
          ),
          progressIndicatorBuilder:
              OctoProgressIndicator.circularProgressIndicator(),
          height: 200,
          width: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            if (widget.filmWorker?.gender == 2) {
              return SvgPicture.asset(
                AppAssets.actorImageIcon,
                height: 200,
                width: 120,
                fit: BoxFit.cover,
              );
            } else {
              return SvgPicture.asset(
                AppAssets.actressImageIcon,
                height: 200,
                width: 120,
                fit: BoxFit.cover,
              );
            }
          },
        ),
      ),
      subtitle: Column(
        children: [
          AutoSizeText(
            widget.filmWorker!.originalName!,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          AutoSizeText(
            '${context.localizations.production_job} ${widget.filmWorker?.job} ${context.localizations.in_preposition} ${widget.filmWorker?.knownForDepartment}',
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
