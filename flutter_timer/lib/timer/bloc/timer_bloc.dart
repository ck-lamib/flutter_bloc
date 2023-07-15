import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_timer/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

// class TimerBloc extends Bloc<TimerEvent, TimerState> {
//   final Tickers _ticker;
//   static const int _duration = 60;
//   StreamSubscription<int>? _tickerSubscription;

//   //TimerBloc(this._ticker):super(TimerInitial(_duration)){}
//   TimerBloc({required Tickers ticker})
//       : _ticker = ticker,
//         super(const TimerInitial(_duration)) {
//     on<TimerStarted>(onStart);
//     on<TimerPaused>(onPaused);
//     on<TimerResumed>(onResumed);
//     on<TimerReset>(onReset);
//     on<TimerTicked>(onTimerTicked);
//   }

//   @override
//   Future<void> close() {
//     _tickerSubscription?.cancel();
//     return super.close();
//   }

//   void onStart(TimerStarted event, Emitter<TimerState> emit) {
//     emit(TimerRunInProgress(event.duration));
//     _tickerSubscription?.cancel();
//     _tickerSubscription =
//         _ticker.tick(ticks: event.duration).listen((duration) => TimerTicked(duration: duration));
//   }

//   void onPaused(TimerPaused event, Emitter<TimerState> emit) {
//     if (state is TimerRunInProgress) {
//       _tickerSubscription?.pause();
//       emit(TimerRunPause(state.duration));
//     }
//   }

//   void onResumed(TimerResumed event, Emitter<TimerState> emit) {
//     if (state is TimerRunPause) {
//       _tickerSubscription?.resume();
//       emit(TimerRunInProgress(state.duration));
//     }
//   }

//   void onReset(TimerReset event, Emitter<TimerState> emit) {
//     _tickerSubscription?.cancel();
//     emit(const TimerInitial(_duration));
//   }

//   void onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
//     emit(event.duration > 0 ? TimerRunInProgress(event.duration) : const TimerRunComplete());
//   }
// }

// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_timer/ticker.dart';

// part 'timer_event.dart';
// part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({required Tickers ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
    on<TimerTicked>(_onTicked);
  }

  final Tickers _ticker;
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0 ? TimerRunInProgress(event.duration) : const TimerRunComplete(),
    );
  }
}
