import 'package:film_flu/domain/enums/media_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProvider extends StateNotifier<MediaType> {
  _init() {
    state = MediaType.movie;
  }

  HomeProvider() : super(MediaType.movie) {
    _init();
  }

  void setMediaTypeSelected(MediaType mediaTypeSelected) {
    state = mediaTypeSelected;
  }
}

final homeProvider = StateNotifierProvider<HomeProvider, MediaType>(
  (ref) => HomeProvider(),
);
