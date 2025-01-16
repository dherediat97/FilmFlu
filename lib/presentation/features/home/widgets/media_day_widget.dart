import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/notifiers/media_notifier.dart';
import 'package:film_flu/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaDayWidget extends ConsumerWidget {
  const MediaDayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaDayDataState = ref.read(fetchMediaDayProvider(MediaType.movie));

    return mediaDayDataState.when(
      error: (error, stackTrace) => const SizedBox(),
      loading: () => Shimmer(child: buildMediaDayWidget(context)),
      data: (state) {
        return state.uiState.isLoading() && state.mediaItem == null
            ? Shimmer(child: buildMediaDayWidget(context))
            : BackgroundImageMediaItem(
                key: key,
                isHomeScreen: true,
                mediaItem: state.mediaItem,
                productionCompanyImage: '',
              );
      },
    );
  }
}
