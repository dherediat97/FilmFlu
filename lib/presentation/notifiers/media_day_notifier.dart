import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_day_notifier.g.dart';

@riverpod
class MediaDay extends _$MediaDay {
  @override
  Future<MediaDayItemState?> build(MediaFilter mediaFilter) async {
    return await getMediaListByMediaType(mediaFilter);
  }

  Future<MediaDayItemState?> getMediaListByMediaType(
    MediaFilter mediaFilter,
  ) async {
    final mediaDataItemResponse = await ref
        .read(mediaRepositoryProvider)
        .getMediaDataDay(mediaFilter.mediaTypeSelected);

    return MediaDayItemState(
      mediaItem: mediaDataItemResponse,
      title: mediaFilter.mediaTypeSelected == MediaType.movie
          ? mediaDataItemResponse.title
          : mediaDataItemResponse.name,
      productionCompanyImage:
          mediaDataItemResponse.productionCompanies!.isNotEmpty
              ? mediaDataItemResponse.productionCompanies!.first.logoPath
              : '',
    );
  }
}

class MediaDayItemState {
  final MediaItemEntity? mediaItem;
  final String? title;
  final String? productionCompanyImage;

  MediaDayItemState copyWith({
    MediaItemEntity? mediaItem,
    String? title,
    String? productionCompanyImage,
  }) {
    return MediaDayItemState(
      mediaItem: mediaItem ?? this.mediaItem,
      title: title ?? this.title,
      productionCompanyImage: productionCompanyImage,
    );
  }

  const MediaDayItemState({
    this.mediaItem,
    this.title,
    this.productionCompanyImage,
  });
}
