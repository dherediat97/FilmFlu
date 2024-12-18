import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';

abstract class MediaUseCase {
  Future<MediaItemEntity> getMediaItem({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  });

  Future<Result<CreditsMediaEntity>> getCredits({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  });

  Future<Result<List<ReviewEntity>?>> getReviews({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  });

  Future<Result<MediaResponseEntity>> getMedia({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  });

  Future<(int totalItems, List<MediaSimpleItemEntity> items)>
      getMediaDataByGenre({
    required MediaType mediaTypeSelected,
    required int genreId,
    required String languageId,
  });

  // Future<Result<List<MediaSimpleItemEntity>>> paginateMediaData({
  //   required MediaType mediaTypeSelected,
  //   required int genreId,
  //   required int page,
  // });

  Future<(int totalItems, List<MediaSimpleItemEntity> items)> getMovies({
    required int genreId,
    String languageId,
  });
  Future<(int totalItems, List<MediaSimpleItemEntity> items)> getTVSeries({
    required int genreId,
    String languageId,
  });
  Future<Result<List<MediaItemEntity>>> searchMediaData({
    required MediaType mediaTypeSelected,
    required String query,
  });
  Future<Result<MediaItemEntity?>> getMediaDataDay({
    required MediaType mediaTypeSelected,
  });
}

class MediaUseCaseImpl extends MediaUseCase {
  final MediaRepository mediaRepository;

  MediaUseCaseImpl(this.mediaRepository);

  @override
  Future<MediaItemEntity> getMediaItem({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  }) async {
    return await mediaRepository.getMediaItem(
      mediaTypeSelected: mediaTypeSelected,
      mediaTypeId: mediaTypeId,
    );
  }

  @override
  Future<Result<CreditsMediaEntity>> getCredits({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  }) async {
    return await mediaRepository.getCredits(
      mediaTypeSelected: mediaTypeSelected,
      mediaTypeId: mediaTypeId,
    );
  }

  @override
  Future<Result<List<ReviewEntity>?>> getReviews({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  }) async {
    return await mediaRepository.getReviews(
      mediaTypeSelected: mediaTypeSelected,
      mediaTypeId: mediaTypeId,
    );
  }

  @override
  Future<Result<MediaResponseEntity>> getMedia({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  }) async {
    return await mediaRepository.getMedia(
      mediaTypeSelected: mediaTypeSelected,
      mediaTypeId: mediaTypeId,
    );
  }

  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)>
      getMediaDataByGenre({
    required MediaType mediaTypeSelected,
    required int genreId,
    required String languageId,
  }) async {
    return await mediaRepository.getMediaDataByGenre(
      mediaTypeSelected: mediaTypeSelected,
      genreId: genreId,
      languageId: languageId,
    );
  }

  // @override
  // Future<Result<List<MediaSimpleItemEntity>>> paginateMediaData({
  //   required MediaType mediaTypeSelected,
  //   required int genreId,
  //   required int page,
  // }) async {
  //   return await mediaListRepository.paginateMediaData(
  //     mediaTypeSelected: mediaTypeSelected,
  //     genreId: genreId,
  //     page: page,
  //   );
  // }

  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)> getMovies({
    required int genreId,
    String languageId = '',
  }) async {
    return mediaRepository.getMovies(
      genreId: genreId,
      languageId: languageId,
    );
  }

  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)> getTVSeries({
    required int genreId,
    String languageId = '',
  }) async {
    return await mediaRepository.getTVSeries(
      genreId: genreId,
      languageId: languageId,
    );
  }

  @override
  Future<Result<List<MediaItemEntity>>> searchMediaData({
    required MediaType mediaTypeSelected,
    required String query,
  }) async {
    return await mediaRepository.searchMediaData(
      mediaTypeSelected: mediaTypeSelected,
      query: query,
    );
  }

  @override
  Future<Result<MediaItemEntity?>> getMediaDataDay({
    required MediaType mediaTypeSelected,
  }) async {
    return await mediaRepository.getMediaDataDay(
      mediaTypeSelected: mediaTypeSelected,
    );
  }
}
