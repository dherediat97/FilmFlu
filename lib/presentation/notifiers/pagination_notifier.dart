import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class PaginationFilter<F> {
  Future<void> applyFilter(F filter);
}

abstract class PaginationController<T, I, F> {
  I get initialPage;

  late I currentPage = initialPage;

  FutureOr<List<T>> loadPage(I page, F filter);

  Future<void> loadNextPage(F filter);

  I nextPage(I currentPage);
}

mixin AsyncPaginationController<T, I, F>
    on AutoDisposeFamilyAsyncNotifier<List<T>, F>
    implements PaginationController<T, I, F> {
  @override
  late I currentPage = initialPage;

  @override
  FutureOr<List<T>> build(F arg) async => loadPage(initialPage, arg);

  @override
  Future<void> loadNextPage(F filter) async {
    state = AsyncLoading<List<T>>();

    final newState = await AsyncValue.guard<List<T>>(() async {
      currentPage = nextPage(currentPage);
      final elements = await loadPage(currentPage, filter);
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

    state = AsyncLoading<List<T>>();

    final newState = await AsyncValue.guard<List<T>>(() async {
      return await loadPage(currentPage, filter);
    });
    state = newState;
  }
}
