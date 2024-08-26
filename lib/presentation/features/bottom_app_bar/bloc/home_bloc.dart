import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

enum MediaType {
  movie(mediaType: 1),
  tv(mediaType: 2),
  search(mediaType: 3);

  const MediaType({required int mediaType});
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MediaListRepositoryContract _repository;

  HomeBloc({
    required MediaListRepositoryContract repositoryContract,
  })  : _repository = repositoryContract,
        super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
        switchCategory: (mediaTypeSelected) =>
            _switchCategory(event, emit, mediaTypeSelected),
      );
    });
  }

  Future<void> _switchCategory(
    HomeEvent event,
    Emitter<HomeState> emit,
    MediaType mediaTypeSelected,
  ) async {
    if (mediaTypeSelected != MediaType.search) {
      emit(state.copyWith(uiState: const UiState.loading()));
      final movieData = await _repository.getMediaDataDay(
        mediaTypeSelected: mediaTypeSelected,
      );

      movieData.when(
        failure: (errorMessage) {
          emit(
            state.copyWith(uiState: const UiState.error()),
          );
        },
        success: (mediaData) {
          emit(
            state.copyWith(
              mediaTypeSelected: mediaTypeSelected,
              uiState: const UiState.success(),
              isHomeScreen: true,
              mediaItem: mediaData,
            ),
          );
        },
      );
    }
  }
}
