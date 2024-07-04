import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_repository_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_detail_event.dart';
part 'media_detail_state.dart';
part 'media_detail_bloc.freezed.dart';

class MediaDetailBloc extends Bloc<MediaDetailEvent, MediaDetailState> {
  final MediaRepositoryContract _repository;

  MediaDetailBloc({
    required MediaRepositoryContract repositoryContract,
  })  : _repository = repositoryContract,
        super(MediaDetailState.initial()) {
    on<MediaDetailEvent>((event, emit) async {
      await event.when(
        getMediaDetails: (String mediaType, int mediaItemId) =>
            _getMediaDetails(event, emit, mediaType, mediaItemId),
        getCredits: (String mediaType, int mediaItemId) =>
            _getCredits(event, emit, mediaType, mediaItemId),
      );
    });
  }

  _getMediaDetails(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
    String mediaType,
    int mediaItemId,
  ) async {
    emit(state.copyWith(uiState: const UiState.loading()));

    final movieData = await _repository.getMediaItem(
      mediaType,
      mediaItemId,
    );
    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error()),
        );
      },
      success: (value) => emit(
          state.copyWith(uiState: const UiState.success(), mediaItem: value)),
    );
  }

  _getCredits(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
    String mediaType,
    int mediaTypeId,
  ) async {
    emit(state.copyWith(uiState: const UiState.loading()));

    final creditsData = await _repository.getCredits(
      mediaType,
      mediaTypeId,
    );

    creditsData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error()),
        );
      },
      success: (value) {
        emit(state.copyWith(uiState: const UiState.success(), credits: value));
      },
    );
  }
}
