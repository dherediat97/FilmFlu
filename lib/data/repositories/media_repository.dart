import 'package:FilmFlu/app/types/errors/network_error.dart';
import 'package:FilmFlu/app/types/repository_error.dart';
import 'package:FilmFlu/app/types/result.dart';
import 'package:FilmFlu/data/models/credits_person_remote_entity.dart';
import 'package:FilmFlu/data/models/media_item_remote_entity.dart';
import 'package:FilmFlu/data/repositories/remote/media_remote_data_source_contract.dart';
import 'package:FilmFlu/domain/models/credits_person_entity.dart';
import 'package:FilmFlu/domain/models/media_item_entity.dart';
import 'package:FilmFlu/domain/repository_contracts/media_repository_contract.dart';

class MediaRepository implements MediaRepositoryContract {
  final MediaRemoteDataSourceContract _movieRemoteDataSourceContract;

  MediaRepository(
    this._movieRemoteDataSourceContract,
  );

  @override
  Future<Result<MediaItemEntity>> getMediaItem(
    String mediaType,
    String mediaTypeId,
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
  Future<Result<CreditsPersonEntity>> getCredits(
    String mediaType,
    String mediaTypeId,
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
