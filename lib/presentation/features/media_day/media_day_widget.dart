import 'package:film_flu/presentation/features/media_day/bloc/media_day_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaDayWidget extends StatelessWidget {
  const MediaDayWidget({
    super.key,
    required this.isMovie,
  });

  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaDayBloc, MediaDayState>(
      builder: (context, state) {
        return state.movie != null
            ? BackgroundImageMediaItem(
                isHomeScreen: true,
                productionCompanyImage: '',
                mediaItem: isMovie ? state.movie : state.serie,
                movieName: isMovie
                    ? state.movie!.title.toString()
                    : state.serie!.name.toString(),
              )
            : const SliverToBoxAdapter(child: PlaceholderLoader());
      },
    );
  }
}
