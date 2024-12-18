import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_list_notifier.g.dart';

@riverpod
Future<(int totalItems, List<MediaSimpleItemEntity> items)> fetchMediaList(
  Ref ref,
  MediaType mediaType,
  int genreId,
  String languageId,
) async {
  return await ref.watch(mediaRepositoryProvider).getMediaDataByGenre(
      mediaTypeSelected: mediaType, genreId: genreId, languageId: languageId);
}

@riverpod
Future<MediaItemEntity> fetchMediaItem(
  Ref ref,
  String id,
  String mediaTypeSelected,
) async {
  return await ref.watch(mediaRepositoryProvider).getMediaItem(
        mediaTypeSelected: MediaType.values.firstWhere(
          (mediaType) => mediaType.name == mediaTypeSelected,
        ),
        mediaTypeId: id,
      );
}
