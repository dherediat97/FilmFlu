import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';

abstract class MediaListRemoteDataSourceContract {
  Future<List<MediaItemRemoteEntity>> getMediaTypeList({
    required MediaType mediaTypeSelected,
    required int genreId,
    String languageId,
  });

  Future<List<MediaItemRemoteEntity>> paginateMediaData({
    required MediaType mediaTypeSelected,
    required int genreId,
    required int page,
  });

  Future<MediaItemRemoteEntity> getMediaDataDay({
    required MediaType mediaTypeSelected,
  });

  Future<List<MediaItemRemoteEntity>> searchMediaData({
    required MediaType mediaTypeSelected,
    required String query,
  });
}
