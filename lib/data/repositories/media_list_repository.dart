import 'package:FilmFlu/app/types/errors/network_error.dart';
import 'package:FilmFlu/app/types/repository_error.dart';
import 'package:FilmFlu/app/types/result.dart';
import 'package:FilmFlu/data/models/media_item_remote_entity.dart';
import 'package:FilmFlu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:FilmFlu/domain/models/media_item_entity.dart';
import 'package:FilmFlu/domain/repository_contracts/media_list_repository_contract.dart';

class MediaListRepository implements MediaListRepositoryContract {
  final MediaListRemoteDataSourceContract _movieRemoteDataSourceContract;

  MediaListRepository(
    this._movieRemoteDataSourceContract,
  );

  @override
  Future<Result<List<MediaItemEntity>>> getMediaList(String mediaType) async {
    try {
      final movieData =
          await _movieRemoteDataSourceContract.getMediaTypeList(mediaType);
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
