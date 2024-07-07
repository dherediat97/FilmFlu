import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/media_data_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_list_event.dart';
part 'media_list_state.dart';
part 'media_list_bloc.freezed.dart';

class MediaListBloc extends Bloc<MediaListEvent, MediaListState> {
  final MediaListRepositoryContract _repository;

  MediaListBloc({
    required MediaListRepositoryContract repositoryContract,
  })  : _repository = repositoryContract,
        super(MediaListState.initial()) {
    on<MediaListEvent>((event, emit) async {
      await event.when(
        getMediaData: () => _getMediaData(
          event,
          emit,
        ),
      );
    });
  }

  _getMediaData(
    MediaListEvent event,
    Emitter<MediaListState> emit,
  ) async {
    emit(state.copyWith(uiState: const UiState.loading()));

    final movieData = await _repository.getMediaData();
    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(
            uiState: const UiState.error(),
            mediaData: null,
          ),
        );
      },
      success: (value) => emit(
        state.copyWith(
          uiState: const UiState.success(),
          mediaData: value,
        ),
      ),
    );
  }
}
