import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class PaginationFilter<F> {
  late F currentFilter;

  Future<void> applyFilter(F filter);
}

abstract class PaginationController<T, I, F> {
  I get initialPage;
  F get initialFilter;

  late I currentPage = initialPage;

  late F currentFilter = initialFilter;

  FutureOr<List<T>> loadPage(I page, F filter);

  Future<void> loadNextPage();

  I nextPage(I currentPage);
}

mixin AsyncPaginationController<T, I, F> on AsyncNotifier<List<T>>
    implements PaginationController<T, I, F> {
  @override
  late I currentPage = initialPage;

  @override
  late F currentFilter = initialFilter;

  @override
  FutureOr<List<T>> build() async => loadPage(initialPage, currentFilter);

  @override
  Future<void> loadNextPage() async {
    state = AsyncLoading<List<T>>();

    final newState = await AsyncValue.guard<List<T>>(() async {
      currentPage = nextPage(currentPage);
      final elements = await loadPage(currentPage, initialFilter);
      return [...?state.valueOrNull, ...elements];
    });
    state = newState;
  }
}

mixin AsyncPaginationFilter<F, T, I> on AsyncPaginationController<T, I, F>
    implements PaginationFilter<F> {
  @override
  Future<void> applyFilter(F filter) async {
    currentPage = initialPage;
    currentFilter = filter;

    state = AsyncLoading<List<T>>();

    final newState = await AsyncValue.guard<List<T>>(() async {
      return await loadPage(currentPage, filter);
    });
    state = newState;
  }
}
