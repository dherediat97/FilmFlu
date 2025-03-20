import 'dart:async';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/search_result_entity.dart';
import 'package:film_flu/domain/use_case/media_use_case.dart';
import 'package:film_flu/domain/use_case/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMediaListProvider =
    AsyncNotifierProvider<SearchedMediaListViewModel, List<MediaItemEntity>>(
      SearchedMediaListViewModel.new,
    );

class SearchedMediaListViewModel extends AsyncNotifier<List<MediaItemEntity>> {
  MediaUseCase get repository => ref.read(mediaProvider);

  @override
  List<MediaItemEntity> build() {
    return [];
  }

  FutureOr<List<SearchResultEntity>> search(
    String languageName,
    String query,
  ) async {
    final items = await repository.searchMediaData(languageName, query);
    if (items.results.isEmpty) {
      return [];
    }
    return items.results;
  }
}
