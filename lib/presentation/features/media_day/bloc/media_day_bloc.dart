import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_day_event.dart';
part 'media_day_state.dart';
part 'media_day_bloc.freezed.dart';

class MediaDayBloc extends Bloc<MediaDayEvent, MediaDayState> {
  final MediaListRepositoryContract _repository;

  MediaDayBloc({
    required MediaListRepositoryContract repositoryContract,
  })  : _repository = repositoryContract,
        super(MediaDayState.initial()) {
    on<MediaDayEvent>(
      (event, emit) async {
        await event.when(
          fetchMovieDay: () => fetchMovieDay(event, emit),
          fetchSerieDay: () => fetchSerieDay(event, emit),
        );
      },
    );
  }
  Future<void> fetchMovieDay(event, emit) async {
    emit(state.copyWith(uiState: const UiState.loading()));

    final movieData = await _repository.getMediaDataDay(
        mediaType: MediaListConstants.movieMediaType);
    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error()),
        );
      },
      success: (movie) {
        emit(
          state.copyWith(
            uiState: const UiState.success(),
            movie: movie,
          ),
        );
      },
    );
  }

  Future<void> fetchSerieDay(event, emit) async {
    emit(state.copyWith(uiState: const UiState.loading()));

    final movieData = await _repository.getMediaDataDay(
        mediaType: MediaListConstants.serieMediaType);
    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error()),
        );
      },
      success: (serie) {
        emit(
          state.copyWith(
            uiState: const UiState.success(),
            serie: serie,
          ),
        );
      },
    );
  }
}
