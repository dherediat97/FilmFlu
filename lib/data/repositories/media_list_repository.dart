import 'package:film_flu/app/types/errors/network_error.dart';
import 'package:film_flu/app/types/repository_error.dart';
import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';

class MediaListRepository implements MediaListRepositoryContract {
  final MediaListRemoteDataSourceContract _movieRemoteDataSourceContract;

  MediaListRepository(
    this._movieRemoteDataSourceContract,
  );

  @override
  Future<Result<List<MediaItemEntity>>> getMediaList({
    required String mediaType,
    required int genreId,
    String? languageId,
  }) async {
    try {
      final movieData = await _movieRemoteDataSourceContract.getMediaTypeList(
        mediaType: mediaType,
        genreId: genreId,
        languageId: languageId ?? '',
      );
      return Result.success(movieData.map((e) => e.toMediaEntity()).toList());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }
}
