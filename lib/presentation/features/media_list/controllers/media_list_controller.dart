import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_list_controller.g.dart';

@riverpod
class MediaListController extends _$MediaListController {
  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)> build({
    required MediaType mediaTypeSelected,
    required int genreId,
    String? languageId,
  }) async {
    final mediaListRepository = ref.watch(mediaRepositoryProvider);
    return await mediaListRepository.getMediaDataByGenre(
      mediaTypeSelected: mediaTypeSelected,
      genreId: genreId,
      languageId: languageId ?? '',
    );
  }
}
