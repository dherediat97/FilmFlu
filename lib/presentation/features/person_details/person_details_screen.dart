import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/core/utils/util_date.dart';
import 'package:film_flu/domain/models/credit_actor_entity.dart';
import 'package:film_flu/domain/models/credit_production_entity.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/presentation/features/person_details/bloc/person_details_bloc.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/presentation/widgets/default_circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class PersonDetailsPage extends StatefulWidget {
  const PersonDetailsPage({
    super.key,
    required this.personId,
  });

  final String personId;

  @override
  State<PersonDetailsPage> createState() => _PersonDetailsPagePage();
}

class _PersonDetailsPagePage extends State<PersonDetailsPage> {
  bool isActorWorkSelected = true;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      containerChild: SingleChildScrollView(
        controller: ScrollController(),
        child: BlocBuilder<PersonDetailsBloc, PersonDetailsState>(
          builder: (context, state) {
            PersonEntity? person = state.person;

            List<CreditActorEntity>? creditsListAsActor = state
                .person?.credits?.cast
                .where((element) => element.character != null)
                .where((element) => element.title != null)
                .toList();

            List<CreditProductionEntity>? creditsListAsProduction = state
                .person?.credits?.crew
                .where((element) => element.job != null)
                .where((element) => element.title != null)
                .toList();

            return person != null
                ? Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.network(
                                '${AppUrls.personImgBaseUrl}${person.profilePath}',
                                height: 160,
                                width: 150,
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
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'ShadowsIntoLight',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Row(
                                      children: [
                                        if (person.birthday != null &&
                                            person.birthday?.isNotEmpty ==
                                                true) ...[
                                          const Icon(
                                            Icons.celebration,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                            child: Text(
                                              parseDate(person.birthday!)
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ]
                                      ],
                                    ),
                                  ),
                                  if (person.deathday != null &&
                                      person.deathday?.isNotEmpty == true) ...[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Symbols.skull,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                            child: Text(
                                              parseDate(person.deathday!)
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                  const SizedBox(height: 10),
                                  if (person.placeOfBirth != null &&
                                      person.placeOfBirth!.isNotEmpty) ...[
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.public,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: SizedBox(
                                            width: 220,
                                            child: AutoSizeText(
                                              person.placeOfBirth
                                                  .toString()
                                                  .trim(),
                                              maxFontSize: 20,
                                              minFontSize: 15,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (person.biography != null &&
                                    person.biography!.isNotEmpty) ...[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Text(
                                      person.biography.toString(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      context.localizations.films_worked,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 32.0),
                                    child: SegmentedButton<bool>(
                                      selectedIcon: null,
                                      emptySelectionAllowed: false,
                                      showSelectedIcon: false,
                                      selected: <bool>{isActorWorkSelected},
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty
                                            .resolveWith<Color>(
                                          (Set<WidgetState> states) {
                                            if (states.contains(
                                                WidgetState.selected)) {
                                              return AppColors.primaryColor;
                                            }
                                            return Colors.white24;
                                          },
                                        ),
                                      ),
                                      segments: [
                                        ButtonSegment<bool>(
                                          label: Text(
                                            context
                                                .localizations.character_cast,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          value: true,
                                        ),
                                        ButtonSegment<bool>(
                                          label: Text(
                                            context
                                                .localizations.production_cast,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          value: false,
                                        ),
                                      ],
                                      onSelectionChanged:
                                          (Set<bool> newSelection) {
                                        setState(() {
                                          isActorWorkSelected =
                                              newSelection.first;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        isActorWorkSelected
                            ? GridView.builder(
                                itemCount: creditsListAsActor!.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 400,
                                  mainAxisSpacing: 50,
                                  crossAxisSpacing: 50,
                                ),
                                itemBuilder: (context, index) {
                                  CreditActorEntity filmPerson =
                                      creditsListAsActor[index];
                                  String? movieTitle = filmPerson.title != null
                                      ? '${filmPerson.character} ${context.localizations.in_preposition} ${filmPerson.title}'
                                      : '${filmPerson.character}';
                                  return InkWell(
                                    onTap: () {
                                      context.push(
                                        '/mediaItemDetails/${filmPerson.id}',
                                      );
                                    },
                                    child: GridTile(
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            child: Image.network(
                                              '${AppUrls.personImgBaseUrl}${filmPerson.backdropPath}',
                                              height: 160,
                                              width: 150,
                                              fit: BoxFit.cover,
                                              frameBuilder: (context, child,
                                                      loadingProgress, sync) =>
                                                  DefaultCircularLoader(
                                                loadingProgress: null,
                                                child: child,
                                              ),
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.network(
                                                  height: 160,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                  '${AppUrls.personImgBaseUrl}${person.profilePath}',
                                                );
                                              },
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                return DefaultCircularLoader(
                                                    loadingProgress:
                                                        loadingProgress,
                                                    child: child);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 16.0,
                                            ),
                                            child: AutoSizeText(
                                              '${context.localizations.actor_job} $movieTitle',
                                              textAlign: TextAlign.center,
                                              maxLines: 3,
                                              minFontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : GridView.builder(
                                itemCount: creditsListAsProduction?.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 400,
                                  mainAxisSpacing: 50,
                                  crossAxisSpacing: 50,
                                ),
                                itemBuilder: (context, index) {
                                  CreditProductionEntity filmPerson =
                                      creditsListAsProduction![index];

                                  String? movieTitle = filmPerson.title != null
                                      ? '${filmPerson.job} ${context.localizations.in_preposition} ${filmPerson.title}'
                                      : '${filmPerson.job}';
                                  return InkWell(
                                    onTap: () {
                                      context.push(
                                        '${AppRoutePaths.mediaDetailsRoute}/${filmPerson.id}',
                                      );
                                    },
                                    child: GridTile(
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            child: Image.network(
                                              filmPerson.backdropPath != null
                                                  ? '${AppUrls.personImgBaseUrl}${filmPerson.backdropPath}'
                                                  : '${AppUrls.personImgBaseUrl}${person.profilePath}',
                                              height: 160,
                                              width: 150,
                                              fit: BoxFit.cover,
                                              frameBuilder: (context, child,
                                                      loadingProgress, sync) =>
                                                  DefaultCircularLoader(
                                                loadingProgress: null,
                                                child: child,
                                              ),
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.network(
                                                  height: 160,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                  '${AppUrls.personImgBaseUrl}${person.profilePath}',
                                                );
                                              },
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                return DefaultCircularLoader(
                                                    loadingProgress:
                                                        loadingProgress,
                                                    child: child);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 16.0,
                                            ),
                                            child: AutoSizeText(
                                              '${context.localizations.production_job} $movieTitle',
                                              textAlign: TextAlign.center,
                                              maxLines: 3,
                                              minFontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
