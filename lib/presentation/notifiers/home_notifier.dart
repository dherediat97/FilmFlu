import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProvider extends StateNotifier<int> {
  _init() {
    state = 0;
  }

  HomeProvider() : super(0) {
    _init();
  }

  void setMediaTypeSelected(int mediaTypeSelected) {
    state = mediaTypeSelected;
  }
}

final homeProvider = StateNotifierProvider<HomeProvider, int>(
  (ref) => HomeProvider(),
);
