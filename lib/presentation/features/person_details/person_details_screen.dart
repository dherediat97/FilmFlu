import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/presentation/features/person_details/widgets/sliver_app_delegate.dart';
import 'package:film_flu/presentation/features/person_details/widgets/actor_credits.dart';
import 'package:film_flu/presentation/features/person_details/widgets/person_details.dart';
import 'package:film_flu/presentation/features/person_details/widgets/production_credits.dart';
import 'package:film_flu/presentation/notifiers/models/person_state.dart';
import 'package:film_flu/presentation/notifiers/person_notifier.dart';
import 'package:film_flu/presentation/features/common/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return personEntityDetails(state);
  }

  personEntityDetails(AsyncValue<PersonEntity> state) {
    final person = state.valueOrNull;
    final initialLoading = state.isLoading;
    return initialLoading
        ? Shimmer(child: buildListItem(initialLoading))
        : DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (
              BuildContext context,
              bool innerBoxIsScrolled,
            ) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 300,
                  toolbarHeight: 0,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  flexibleSpace: FlexibleSpaceBar(
                    background: PersonDetails(person: person),
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
                person!.credits!.cast.isNotEmpty
                    ? Shimmer(child: buildMediaDayWidget(context))
                    : ActorCreditsWidget(
                      person: person,
                      credits: person.credits!.cast,
                    ),
                person.credits!.crew.isNotEmpty
                    ? Shimmer(child: buildMediaDayWidget(context))
                    : ProductionCreditsWidget(
                      person: person,
                      credits: person.credits!.crew,
                    ),
              ],
            ),
          ),
        );
  }
}
