import 'dart:async';

import 'package:geddy_done/data/repositories/timer/timer_repository.dart';
import 'package:geddy_done/data/services/notifications/pomodoro_notification.dart';
import 'package:geddy_done/domain/models/pomodoro.dart';
import 'package:geddy_done/utils/result.dart';

class TimerRepositoryRemote implements TimerRepository {
  TimerRepositoryRemote({
    required PomodoroNotification notification,
    Duration? this.duration,
  })  : _notification = notification,
        _state = Pomodoro(
          currentDuration: duration ?? Duration(minutes: 25),
        ) {
    _stateController = StreamController<Pomodoro>.broadcast();
  }

  final PomodoroNotification _notification;
  late Timer _timer;
  Pomodoro _state;
  late final StreamController<Pomodoro> _stateController;
  Duration? duration;

  @override
  Stream<Pomodoro> get stateStream => _stateController.stream;

  @override
  Pomodoro get currentState => _state;

  void _emitState(Pomodoro newState) {
    _state = newState;
    _stateController.add(_state);
  }

  @override
  Future<Result<void>> start() async {
    if (_state.isRunning) return Result.ok(null);

    _emitState(_state.copyWith(isRunning: true));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!_state.isRunning) {
        timer.cancel();
        return;
      }

      if (_state.currentDuration.inSeconds == 0) {
        await reset();
        await _notification.notify();
      } else {
        _emitState(_state.copyWith(
          currentDuration: _state.currentDuration - const Duration(seconds: 1),
        ));
      }
    });

    return Result.ok(null);
  }

  @override
  Future<Result<void>> pause() async {
    _emitState(_state.copyWith(isRunning: false));
    _timer.cancel();
    return Result.ok(null);
  }

  @override
  Future<Result<void>> reset() async {
    _timer.cancel();
    _emitState(_state.copyWith(
      currentDuration: _state.initialDuration,
      isRunning: false,
    ));
    return Result.ok(null);
  }

  @override
  void dispose() {
    _timer.cancel();
    _stateController.close();
  }
}
