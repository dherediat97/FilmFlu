import 'package:film_flu/app/types/ui_state.dart';
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
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        return current.uiState.isSuccess();
      },
      listener: (context, state) {},
      buildWhen: (previous, current) {
        return current.mediaItem != previous.mediaItem;
      },
      builder: (context, state) {
        if (state.mediaItem != null && !state.uiState.isLoading()) {
          return BackgroundImageMediaItem(
            key: key,
            isHomeScreen: true,
            mediaItem: state.mediaItem,
            productionCompanyImage: '',
          );
        } else {
          return const PlaceholderLoader();
        }
      },
    );
  }
}
