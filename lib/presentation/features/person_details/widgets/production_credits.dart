import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/models/credit_production_entity.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/presentation/widgets/default_circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductionCreditsWidget extends StatelessWidget {
  const ProductionCreditsWidget({
    super.key,
    required this.person,
    required this.credits,
  });

  final PersonEntity person;
  final List<CreditProductionEntity> credits;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: credits.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 280,
          mainAxisExtent: 240,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
        ),
        itemBuilder: (context, index) {
          CreditProductionEntity filmPerson = credits[index];

          String? movieTitle = filmPerson.title != null
              ? '${filmPerson.job} ${context.localizations.in_preposition} ${filmPerson.title}'
              : '${filmPerson.job}';
          return IconButton(
            onPressed: () {
              AppConstants.mediaTypeId = filmPerson.id;
              context.push(
                '${AppRoutePaths.mediaDetailsRoute}/${filmPerson.id}',
              );
            },
            icon: GridTile(
              header: ClipRRect(
                borderRadius: BorderRadius.circular(32.0),
                child: Image.network(
                  filmPerson.backdropPath != null
                      ? '${AppUrls.personImgBaseUrl}${filmPerson.backdropPath}'
                      : '${AppUrls.personImgBaseUrl}${person.profilePath}',
                  height: 160,
                  width: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      height: 160,
                      width: 150,
                      fit: BoxFit.cover,
                      '${AppUrls.personImgBaseUrl}${person.profilePath}',
                    );
                  },
                  loadingBuilder: (_, child, progress) =>
                      DefaultCircularLoader(progress: progress, child: child),
                ),
              ),
              footer: Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                ),
                child: AutoSizeText(
                  '${context.localizations.production_job} $movieTitle',
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  minFontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              child: Container(),
            ),
          );
        },
      ),
    );
  }
}
