import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState.initial()) {
    on<SplashEvent>((event, emit) async {
      await event.when(
        unSplashInNMilliseconds: (milliseconds) =>
            _unSplashInNMilliseconds(event, emit, milliseconds),
      );
    });
  }

  FutureOr<void> _unSplashInNMilliseconds(
    SplashEvent event,
    Emitter<SplashState> emit,
    int milliseconds,
  ) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
    emit(const SplashState.splashed());
  }
}
