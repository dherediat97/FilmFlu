import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/person_details/widgets/sliver_app_delegate.dart';
import 'package:film_flu/presentation/features/person_details/widgets/actor_credits.dart';
import 'package:film_flu/presentation/features/person_details/widgets/person_details.dart';
import 'package:film_flu/presentation/features/person_details/widgets/production_credits.dart';
import 'package:film_flu/presentation/notifiers/person_notifier.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonDetailsPage extends ConsumerStatefulWidget {
  const PersonDetailsPage({
    super.key,
    required this.personId,
  });

  final String personId;

  @override
  ConsumerState<PersonDetailsPage> createState() => _PersonDetailsPagePage();
}

class _PersonDetailsPagePage extends ConsumerState<PersonDetailsPage>
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
    var person = ref
        .watch(fetchPersonDetailsProvider(
          widget.personId,
        ))
        .value;

    // int lengthCast = person.creditsAsActor?.isNotEmpty == true ? 1 : 0;
    // int lengthCrew = person.creditsAsProduction?.isNotEmpty == true ? 1 : 0;

    return person != null
        ? ScaffoldPage(
            child: DefaultTabController(
              length: 2,
              // length: lengthCast + lengthCrew,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: 300,
                      toolbarHeight: 0,
                      forceElevated: innerBoxIsScrolled,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      flexibleSpace: FlexibleSpaceBar(
                        background: PersonDetails(
                          person: person,
                        ),
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ActorCreditsWidget(
                      person: person,
                      credits: person.credits!.cast,
                    ),
                    ProductionCreditsWidget(
                      person: person,
                      credits: person.credits!.crew,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
