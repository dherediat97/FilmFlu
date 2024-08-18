import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/presentation/features/person_details/widgets/sliver_app_delegate.dart';
import 'package:film_flu/presentation/features/person_details/bloc/person_details_bloc.dart';
import 'package:film_flu/presentation/features/person_details/widgets/actor_credits.dart';
import 'package:film_flu/presentation/features/person_details/widgets/person_details.dart';
import 'package:film_flu/presentation/features/person_details/widgets/production_credits.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonDetailsPage extends StatefulWidget {
  const PersonDetailsPage({
    super.key,
    required this.personId,
  });

  final String personId;

  @override
  State<PersonDetailsPage> createState() => _PersonDetailsPagePage();
}

class _PersonDetailsPagePage extends State<PersonDetailsPage>
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
    return BlocBuilder<PersonDetailsBloc, PersonDetailsState>(
      builder: (context, state) {
        PersonEntity? person = state.person;

        int lengthCast = state.creditsAsActor?.isNotEmpty == true ? 1 : 0;
        int lengthCrew = state.creditsAsProduction?.isNotEmpty == true ? 1 : 0;

        return person != null
            ? ScaffoldPage(
                child: DefaultTabController(
                  length: lengthCast + lengthCrew,
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          expandedHeight: 300,
                          toolbarHeight: 0,
                          forceElevated: innerBoxIsScrolled,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          flexibleSpace: FlexibleSpaceBar(
                            background: PersonDetails(
                              person: person,
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          floating: true,
                          delegate: SliverAppBarDelegate(
                            TabBar(controller: _tabController, tabs: [
                              Tab(
                                icon: const Icon(Icons.movie),
                                text: context.localizations.character_cast,
                              ),
                              Tab(
                                icon: const Icon(Icons.movie),
                                text: context.localizations.production_cast,
                              )
                            ]),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        ActorCreditsWidget(
                          person: person,
                          credits: state.creditsAsActor ?? [],
                        ),
                        ProductionCreditsWidget(
                          person: person,
                          credits: state.creditsAsProduction ?? [],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
