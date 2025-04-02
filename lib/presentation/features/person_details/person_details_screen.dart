import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/person_details/widgets/person_details.dart';
import 'package:film_flu/presentation/features/person_details/widgets/sliver_app_delegate.dart';
import 'package:film_flu/presentation/features/person_details/widgets/actor_credits.dart';
import 'package:film_flu/presentation/features/person_details/widgets/production_credits.dart';
import 'package:film_flu/presentation/notifiers/models/person_state.dart';
import 'package:film_flu/presentation/notifiers/person_notifier.dart';
import 'package:film_flu/presentation/features/common/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonItemScreenDetails extends ConsumerStatefulWidget {
  const PersonItemScreenDetails({super.key, required this.personId});

  final int personId;

  @override
  ConsumerState<PersonItemScreenDetails> createState() =>
      _PersonDetailsPagePage();
}

class _PersonDetailsPagePage extends ConsumerState<PersonItemScreenDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      getPersonDetailsProvider(
        PersonState(
          personId: widget.personId,
          languageName: context.localizations.localeName,
        ),
      ),
    );
    final person = state;

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 300,
              toolbarHeight: 0,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: Theme.of(context).colorScheme.surface,
              flexibleSpace: person.when(
                data:
                    (data) => FlexibleSpaceBar(
                      background: PersonDetails(person: data),
                    ),
                error:
                    (error, stackTrace) =>
                        Shimmer(child: buildMediaDayWidget(context)),
                loading: () => Container(),
              ),
            ),
            SliverPersistentHeader(
              floating: true,
              delegate: SliverAppBarDelegate(
                TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      icon: const Icon(Icons.movie),
                      text: context.localizations.character_cast,
                    ),
                    Tab(
                      icon: const Icon(Icons.movie),
                      text: context.localizations.production_cast,
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            person.when(
              data: (data) {
                if (data.credits.cast.isEmpty == true) {
                  return SvgPicture.asset(
                    AppAssets.noImagePerson,
                    height: 160,
                    width: 150,
                    fit: BoxFit.contain,
                  );
                }
                return ActorCreditsWidget(
                  person: data,
                  credits: data.credits.cast,
                );
              },
              error: (error, stackTrace) => Container(),
              loading: () => Shimmer(child: buildTopRowList()),
            ),
            person.when(
              data: (data) {
                if (data.credits.crew.isEmpty == true) {
                  return SvgPicture.asset(
                    AppAssets.noImagePerson,
                    height: 160,
                    width: 150,
                    fit: BoxFit.contain,
                  );
                }
                return ProductionCreditsWidget(
                  person: data,
                  credits: data.credits.crew,
                );
              },
              error: (error, stackTrace) => Container(),
              loading: () => Shimmer(child: buildTopRowList()),
            ),
          ],
        ),
      ),
    );
  }
}
