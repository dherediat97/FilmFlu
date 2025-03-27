import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MediaDataCast extends StatefulWidget {
  const MediaDataCast({super.key, required this.cast});

  final List<ActorEntity> cast;

  @override
  State<MediaDataCast> createState() => _MediaDataCastState();
}

class _MediaDataCastState extends State<MediaDataCast> {
  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 300,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: widget.cast.length,
        (_, index) {
          ActorEntity actor = widget.cast[index];

          return ListTile(
            onTap: () => PersonRoute(id: actor.id).push(context),
            title: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: '${AppUrls.personImgBaseUrl}${actor.profilePath}',
                imageBuilder:
                    (context, imageProvider) => Container(
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
                errorWidget:
                    (context, error, stackTrace) =>
                        actor.gender == 2
                            ? SvgPicture.asset(
                              AppAssets.actorImageIcon,
                              height: 200,
                              width: 120,
                              fit: BoxFit.cover,
                            )
                            : SvgPicture.asset(
                              AppAssets.actressImageIcon,
                              height: 200,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
              ),
            ),
            subtitle: Column(
              children: [
                AutoSizeText(
                  actor.originalName.toString(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                AutoSizeText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  '${context.localizations.actor_job} ${actor.character}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
