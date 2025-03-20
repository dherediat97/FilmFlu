import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/enums/media_type.dart';
import 'package:film_flu/domain/enums/sort_options.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/notifiers/media_day_notifier.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:film_flu/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaDayWidget extends ConsumerStatefulWidget {
  const MediaDayWidget({super.key, required this.mediaTypeSelected});

  final MediaType mediaTypeSelected;

  @override
  ConsumerState<MediaDayWidget> createState() => _MediaDayWidgetState();
}

class _MediaDayWidgetState extends ConsumerState<MediaDayWidget> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      mediaDayProvider(
        MediaDayFilter(
          mediaTypeSelected: widget.mediaTypeSelected,
          languageId: context.localizations.localeName,
          sortBy: SortOptions.popularity,
        ),
      ),
    );

    return mediaDayWidget(state);
  }

  mediaDayWidget(AsyncValue<MediaDayItemState?> state) {
    MediaDayItemState? item = state.value;
    final initialLoading = state.isLoading && item == null;
    final loadingMore = state.isLoading && item != null;

    return initialLoading
        ? Shimmer(child: buildMediaDayWidget(context))
        : loadingMore
        ? Shimmer(child: buildMediaDayWidget(context))
        : BackgroundImageMediaItem(
          key: widget.key,
          isHomeScreen: true,
          mediaItem: item!.mediaItem!,
          title: item.title ?? '',
        );
  }
}
