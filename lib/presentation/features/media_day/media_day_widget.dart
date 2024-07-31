import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_day/bloc/media_day_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaDayWidget extends StatelessWidget {
  const MediaDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaDayBloc, MediaDayState>(
      builder: (context, state) {
        MediaItemEntity? movie = state.mediaDayItem;

        return BackgroundImageMediaItem(
          isHomeScreen: true,
          mediaItem: movie,
          movieName: state.movieName,
        );
      },
    );
  }
}
