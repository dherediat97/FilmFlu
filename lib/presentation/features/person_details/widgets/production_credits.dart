import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/domain/models/credit_production_entity.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          maxCrossAxisExtent: 150,
          mainAxisExtent: 300,
          mainAxisSpacing: 3,
          crossAxisSpacing: 18,
        ),
        itemBuilder: (context, index) {
          CreditProductionEntity filmPerson = credits[index];

          String? movieTitle =
              filmPerson.title != null
                  ? '${filmPerson.job} ${context.localizations.in_preposition} ${filmPerson.title}'
                  : '${filmPerson.job}';

          return ListTile(
            onTap: () => MovieRoute(id: filmPerson.id).push(context),
            title: ClipRRect(
              child: CachedNetworkImage(
                imageUrl:
                    filmPerson.backdropPath != null
                        ? '${AppUrls.personImgBaseUrl}${filmPerson.backdropPath}'
                        : '${AppUrls.personImgBaseUrl}${person.profilePath}',
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
                errorWidget: (context, error, stackTrace) {
                  if (person.gender == 2) {
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
            subtitle: AutoSizeText(
              '${context.localizations.production_job} $movieTitle',
              textAlign: TextAlign.center,
              maxLines: 3,
              minFontSize: 14,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          );
        },
      ),
    );
  }
}
