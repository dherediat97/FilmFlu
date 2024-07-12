import 'dart:async';
import 'package:film_flu/presentation/features/splash_screen/bloc/splash_event.dart';
import 'package:film_flu/presentation/features/splash_screen/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState.initial()) {
    /// Listen for [SplashEvent]s and handle them with the [_unSplashInNMilliseconds] method.
    on<SplashEvent>((event, emit) async {
      await event.when(
        unSplashInNMilliseconds: (milliseconds) =>
            _unSplashInNMilliseconds(event, emit, milliseconds),
      );
    });
  }

  /// Delays for the specified [milliseconds] and then emits a [SplashState.splashed()] state using the provided [emit] function.
  ///
  /// @param event The [SplashEvent] that triggered this method call.
  /// @param emit The function to use for emitting a new state.
  /// @param milliseconds The number of milliseconds to delay before emitting a new state.
  FutureOr<void> _unSplashInNMilliseconds(
    SplashEvent event,
    Emitter<SplashState> emit,
    int milliseconds,
  ) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
    emit(const SplashState.splashed());
  }
}
