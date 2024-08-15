import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/background_image_media_item.dart';
import 'package:film_flu/presentation/widgets/placeholder_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaDayWidget extends StatelessWidget {
  const MediaDayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.mediaItem != null
            ? BackgroundImageMediaItem(
                key: key,
                isHomeScreen: true,
                mediaItem: state.mediaItem,
                productionCompanyImage: '',
              )
            : const PlaceholderLoader();
      },
    );
  }
}
