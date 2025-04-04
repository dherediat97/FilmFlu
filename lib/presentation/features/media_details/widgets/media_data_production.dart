import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:flutter/material.dart';

class MediaDataProduction extends StatelessWidget {
  const MediaDataProduction({super.key, required this.crew});

  final List<FilmWorkerEntity> crew;

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        mainAxisExtent: 300,
        mainAxisSpacing: 3,
        crossAxisSpacing: 18,
      ),
      childrenDelegate: SliverChildBuilderDelegate(childCount: crew.length, (
        _,
        index,
      ) {
        FilmWorkerEntity filmWorker = crew[index];

        return ListTile(
          onTap: () => PersonRoute(id: filmWorker.id).push(context),
          title: ClipRRect(
            child: CachedNetworkImage(
              imageUrl: '${AppUrls.personImgBaseUrl}${filmWorker.profilePath}',
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
              height: 150,
              width: 100,
              fit: BoxFit.contain,
              errorWidget:
                  (context, error, stackTrace) =>
                      filmWorker.gender == 2
                          ? Image.asset(
                            AppAssets.productionPersonMale,
                            height: 150,
                            width: 100,
                            fit: BoxFit.contain,
                          )
                          : Image.asset(
                            AppAssets.productionPersonFemale,
                            height: 150,
                            width: 100,
                            fit: BoxFit.contain,
                          ),
            ),
          ),
          subtitle: Column(
            children: [
              SizedBox(height: 8),
              AutoSizeText(
                filmWorker.originalName!,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 8),
              AutoSizeText(
                '${context.localizations.production_job} ${filmWorker.job} ${context.localizations.in_preposition} ${filmWorker.knownForDepartment}',
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 15),
              ),
            ],
          ),
        );
      }),
    );
  }
}
