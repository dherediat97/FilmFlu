import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/enums/time_windows.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/presentation/features/person_list/widgets/person_carrousel_item.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:film_flu/presentation/view_models/person_list_view_model.dart';
import 'package:film_flu/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PersonListWidget extends ConsumerStatefulWidget {
  const PersonListWidget({
    super.key,
    required this.title,
    required this.timeWindow,
  });

  final String title;
  final TimeWindow timeWindow;

  @override
  ConsumerState<PersonListWidget> createState() => _PersonListWidgetState();
}

class _PersonListWidgetState extends ConsumerState<PersonListWidget> {
  final CarouselController _carouselController = CarouselController();
  PersonListViewModel get viewModel => ref.read(
    personListViewModelProvider(
      TrendingPersonFilter(
        timeWindow: widget.timeWindow,
        languageId: context.localizations.localeName,
      ),
    ).notifier,
  );
  TrendingPersonFilterNotifier get trendingPersonFilterController => ref.read(
    trendingPersonFilterProvider(
      TrendingPersonFilter(
        timeWindow: widget.timeWindow,
        languageId: context.localizations.localeName,
      ),
    ).notifier,
  );

  @override
  void initState() {
    super.initState();
    _carouselController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _carouselController.removeListener(_loadMore);
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trendingPersonFilter = ref.watch(
      trendingPersonFilterProvider(
        TrendingPersonFilter(
          timeWindow: widget.timeWindow,
          languageId: context.localizations.localeName,
        ),
      ),
    );
    final state = ref.watch(personListViewModelProvider(trendingPersonFilter));

    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.axisDirection == AxisDirection.down &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent) {
          if (viewModel.canLoadMore) {
            viewModel.loadNextPage(trendingPersonFilter);
          }
        }
        return true;
      },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: mediaWidgetList(state),
      ),
    );
  }

  mediaWidgetList(AsyncValue<List<PersonEntity>> state) {
    final items = state.valueOrNull ?? [];
    final initialLoading = state.isLoading && items.isEmpty;

    return initialLoading
        ? Shimmer(child: buildListItem(initialLoading))
        : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.timeWindow == TimeWindow.day) ...[
              AutoSizeText(
                widget.title,
                maxFontSize: 30,
                minFontSize: 20,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                height: 300,
                child: CarouselView(
                  itemSnapping: true,
                  controller: _carouselController,
                  padding: const EdgeInsets.all(8.0),
                  itemExtent: 200,
                  onTap: (index) {
                    context.push(
                      '${AppRoutePaths.personRoute}/${items[index].id}',
                    );
                  },
                  children: List.generate(items.length, (int index) {
                    return PersonCarrouselItem(personEntity: items[index]);
                  }),
                ),
              ),
            ],

            if (widget.timeWindow == TimeWindow.week) ...[
              AutoSizeText(
                widget.title,
                maxFontSize: 30,
                minFontSize: 20,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: CarouselView(
                  itemSnapping: true,
                  controller: _carouselController,
                  padding: const EdgeInsets.all(8.0),
                  itemExtent: 200,
                  onTap: (index) {
                    context.push(
                      '${AppRoutePaths.personRoute}/${items[index].id}',
                    );
                  },
                  children: List.generate(items.length, (int index) {
                    return PersonCarrouselItem(personEntity: items[index]);
                  }),
                ),
              ),
            ],
          ],
        );
  }

  _loadMore() {
    final offset = _carouselController.offset;
    final maxOffset = _carouselController.position.maxScrollExtent;
    final isOutOfRange = _carouselController.position.outOfRange;
    final hasReachedTheEnd = offset >= maxOffset && !isOutOfRange;

    if (hasReachedTheEnd) {
      viewModel.loadNextPage(
        ref.read(
          trendingPersonFilterProvider(
            TrendingPersonFilter(
              timeWindow: widget.timeWindow,
              languageId: context.localizations.localeName,
            ),
          ),
        ),
      );
    }
  }
}
