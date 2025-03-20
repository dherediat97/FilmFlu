import 'dart:async';

import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/domain/use_case/person_use_case.dart';
import 'package:film_flu/domain/use_case/provider.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:film_flu/presentation/notifiers/base/pagination_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final personListViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<PersonListViewModel, List<PersonEntity>, TrendingPersonFilter>(
      PersonListViewModel.new,
    );

class PersonListViewModel
    extends
        AutoDisposeFamilyAsyncNotifier<List<PersonEntity>, TrendingPersonFilter>
    with
        AsyncPaginationController<PersonEntity, int, TrendingPersonFilter>,
        AsyncPaginationFilter<TrendingPersonFilter, PersonEntity, int> {
  PersonUseCase get repository => ref.read(personProvider);

  var _canLoadMore = true;

  get canLoadMore => _canLoadMore;

  @override
  int get initialPage => 1;

  @override
  FutureOr<List<PersonEntity>> loadPage(
    int page,
    TrendingPersonFilter currentFilter,
  ) async {
    final (totalItems, items) = await repository.getTrendingPersons(
      currentFilter.timeWindow,
      currentFilter.languageId,
      page,
    );
    final previousLength = state.valueOrNull?.length ?? 0;
    _canLoadMore = previousLength + items.length < totalItems;
    return items;
  }

  @override
  int nextPage(int currentPage) => currentPage + 1;

  void refresh() {
    currentPage = initialPage;
  }
}
