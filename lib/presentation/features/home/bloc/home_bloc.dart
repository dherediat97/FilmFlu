import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

enum MediaType {
  movie(mediaType: 1),
  tv(mediaType: 2);

  const MediaType({required int mediaType});
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
          switchCategory: (mediaTypeSelected) =>
              _switchCategory(event, emit, mediaTypeSelected));
    });
  }

  Future<void> _switchCategory(
    HomeEvent event,
    Emitter<HomeState> emit,
    MediaType mediaTypeSelected,
  ) async {
    emit(state.copyWith(mediaTypeSelected: mediaTypeSelected));
  }
}
