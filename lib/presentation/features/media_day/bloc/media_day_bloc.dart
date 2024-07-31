import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
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
    on<MediaDayEvent>((event, emit) async {
      await event.when(
        fetchMediaDayItem: () => fetchMediaDay(event, emit),
      );
    });
  }

  Future<void> fetchMediaDay(event, emit) async {
    emit(state.copyWith(uiState: const UiState.loading()));

    final movieData = await _repository.getMediaDataDay();
    movieData.when(failure: (errorMessage) {
      emit(
        state.copyWith(uiState: const UiState.error()),
      );
    }, success: (movie) {
      emit(state.copyWith(
        uiState: const UiState.success(),
        movieName: movie.title?.isNotEmpty == true
            ? movie.title.toString()
            : movie.name.toString(),
        mediaDayItem: movie,
      ));
    });
  }
}
