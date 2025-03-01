import 'dart:async';

import 'package:geddy_done/data/repositories/pomodoro/pomodoro_repository.dart';
import 'package:geddy_done/data/services/notifications/pomodoro_notification.dart';
import 'package:geddy_done/domain/models/pomodoro.dart';
import 'package:geddy_done/utils/result.dart';

class PomodoroRepositoryRemote implements PomodoroRepository {
  PomodoroRepositoryRemote({
    required PomodoroNotification notification,
  })  : _notification = notification,
        _state = Pomodoro(
          currentDuration: const Duration(minutes: 25),
        );

  final PomodoroNotification _notification;
  late Timer _timer;
  Pomodoro _state;

  @override
  Pomodoro get state => _state;

  @override
  Future<Result<void>> pause() {
    // TODO: implement pause
    throw UnimplementedError();
  }

  @override
  Future<Result<Pomodoro>> start(
      Function(Pomodoro) modificationCallback) async {
    if (_state.isRunning) return Result.ok(_state);

    _state = _state.copyWith(isRunning: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!_state.isRunning) {
        timer.cancel();
        return;
      }

      if (_state.currentDuration.inSeconds == 0) {
        resetTimer();
        await _notification.notify();
      } else {
        _state = _state.copyWith(
          currentDuration: _state.currentDuration - const Duration(seconds: 1),
        );
      }

      modificationCallback(_state);
    });

    return Result.ok(_state);
  }

  void updateState(Pomodoro state) {
    _state = state;
  }

  void resetTimer() {
    _state = _state.copyWith(
      currentDuration: _state.initialDuration,
      isRunning: false,
    );
    _timer.cancel();
  }
}
