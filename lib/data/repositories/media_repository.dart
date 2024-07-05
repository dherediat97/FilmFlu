import 'package:film_flu/app/types/errors/network_error.dart';
import 'package:film_flu/app/types/repository_error.dart';
import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/data/models/credits_media_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/repositories/remote/media_remote_data_source_contract.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_repository_contract.dart';

class MediaRepository implements MediaRepositoryContract {
  final MediaRemoteDataSourceContract _movieRemoteDataSourceContract;

  MediaRepository(
    this._movieRemoteDataSourceContract,
  );

  @override
  Future<Result<MediaItemEntity>> getMediaItem(
    String mediaType,
    int mediaTypeId,
  ) async {
    try {
      final mediaItemData = await _movieRemoteDataSourceContract.getMediaDetail(
        mediaType,
        mediaTypeId,
      );

      return Result.success(mediaItemData.toMediaEntity());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<CreditsMediaEntity>> getCredits(
    String mediaType,
    int mediaTypeId,
  ) async {
    try {
      final creditData = await _movieRemoteDataSourceContract.getCredits(
        mediaType,
        mediaTypeId,
      );
      return Result.success(creditData.toCreditsEntity());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }
}
