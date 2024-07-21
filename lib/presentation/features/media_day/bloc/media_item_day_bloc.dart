import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_item_day_event.dart';
part 'media_item_day_state.dart';
part 'media_item_day_bloc.freezed.dart';

class MediaItemDayBloc extends Bloc<MediaItemDayEvent, MediaItemDayState> {
  MediaItemDayBloc() : super(const _Initial()) {
    on<MediaItemDayEvent>((event, emit) {});
  }
}
