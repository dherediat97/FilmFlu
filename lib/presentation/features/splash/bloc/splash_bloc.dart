import 'dart:async';
import 'package:film_flu/presentation/features/splash/bloc/splash_event.dart';
import 'package:film_flu/presentation/features/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
