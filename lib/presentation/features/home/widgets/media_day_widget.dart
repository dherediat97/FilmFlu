import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/notifiers/media_day_notifier.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:film_flu/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaDayWidget extends ConsumerStatefulWidget {
  const MediaDayWidget({
    super.key,
    required this.mediaTypeSelected,
  });

  final MediaType mediaTypeSelected;

  @override
  ConsumerState<MediaDayWidget> createState() => _MediaDayWidgetState();
}

class _MediaDayWidgetState extends ConsumerState<MediaDayWidget> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mediaDayProvider(MediaFilter(
      mediaTypeSelected: widget.mediaTypeSelected,
      genredId: 0,
      languageId: context.localizations.localeName,
    )));

    return mediaDayWidget(state);
  }

  mediaDayWidget(AsyncValue<MediaItemEntity?> state) {
    MediaItemEntity? item = state.value;
    final initialLoading = state.isLoading && item == null;
    final loadingMore = state.isLoading && item != null;

    return initialLoading
        ? Shimmer(child: buildMediaDayWidget(context))
        : loadingMore
            ? const CircularProgressIndicator()
            : BackgroundImageMediaItem(
                key: widget.key,
                isHomeScreen: true,
                mediaItem: item,
                productionCompanyImage: '',
              );
  }
}
