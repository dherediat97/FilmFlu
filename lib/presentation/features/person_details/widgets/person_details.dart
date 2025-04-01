import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/core/utils/util_date.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/symbols.dart';

class PersonDetails extends StatelessWidget {
  const PersonDetails({super.key, required this.person});

  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.network(
                    '${AppUrls.personImgBaseUrl}${person.profilePath}',
                    height: 160,
                    width: 150,
                    errorBuilder: (context, error, stackTrace) {
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
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        person.name,
                        textAlign: TextAlign.start,
                        maxFontSize: 26,
                        minFontSize: 20,
                        stepGranularity: 1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            if (person.birthday.isNotEmpty) ...[
                              Icon(
                                Icons.celebration,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  parseDate(person.birthday).toString(),
                                  textAlign: TextAlign.start,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (person.deathday.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                Symbols.skull,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  parseDate(person.deathday).toString(),
                                  textAlign: TextAlign.start,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      if (person.placeOfBirth.isNotEmpty) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.public,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: 220,
                                child: AutoSizeText(
                                  person.placeOfBirth.toString().trim(),
                                  maxFontSize: 20,
                                  minFontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (person.biography.isNotEmpty)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        person.biography.toString(),
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
