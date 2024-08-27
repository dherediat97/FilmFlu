import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class FilmActorItem extends StatefulWidget {
  const FilmActorItem({
    super.key,
    required this.actor,
  });

  final ActorEntity? actor;

  @override
  State<FilmActorItem> createState() => _FilmActorItemState();
}

class _FilmActorItemState extends State<FilmActorItem> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: widget.actor == null
          ? buildTopRowItem()
          : ListTile(
              onTap: () {
                AppConstants.personId = widget.actor!.id;
                context.push(
                    '${AppRoutePaths.personDetailsRoute}/${widget.actor?.id}');
              },
              title: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      '${AppUrls.personImgBaseUrl}${widget.actor?.profilePath}',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  height: 200,
                  width: 120,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) {
                    if (widget.actor?.gender == 2) {
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
                    widget.actor!.originalName.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  AutoSizeText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    '${context.localizations.actor_job} ${widget.actor?.character}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
    );
  }
}
