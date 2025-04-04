import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaListNotifier extends StateNotifier<int> {
  _init() {
    state = 1;
  }

  MediaListNotifier() : super(1) {
    _init();
  }

  reset() {
    state = 1;
  }

  loadNewPage() {
    if (state > 3) {
      return;
    }
    state = state + 1;
  }
}

final mediaListProvider = StateNotifierProvider<MediaListNotifier, int>(
  (ref) => MediaListNotifier(),
);
