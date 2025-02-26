import 'dart:async';
import 'package:geddy_done/contracts/timer_notification.dart';
import '../repositories/timer_repository.dart';

class TimerService {
  final TimerRepository _repository;
  final TimerNotification _notification;
  Timer? _timer;

  TimerService({
    required TimerRepository repository,
    required TimerNotification notification,
  })  : _repository = repository,
        _notification = notification;

  void startTimer() {
    var state = _repository.getTimerState();
    if (!state.isRunning) {
      _repository.updateState(state.copyWith(isRunning: true));
      _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    }
  }

  void stopTimer() {
    _timer?.cancel();
    var state = _repository.getTimerState();
    _repository.updateState(state.copyWith(isRunning: false));
  }

  void resetTimer() {
    var state = _repository.getTimerState();
    _repository.updateState(
      state.copyWith(
        currentDuration: state.originalDuration,
        isRunning: false,
      ),
    );
    _timer?.cancel();
  }

  void _onTick(Timer timer) async {
    var state = _repository.getTimerState();
    if (!state.isRunning) {
      timer.cancel();
      return;
    }

    if (state.currentDuration.inSeconds == 0) {
      timer.cancel();
      await _notification.notify();
      resetTimer();
    } else {
      _repository.updateState(
        state.copyWith(
          currentDuration: state.currentDuration - const Duration(seconds: 1),
        ),
      );
    }
  }
}
