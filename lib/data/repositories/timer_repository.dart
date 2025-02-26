import 'package:flutter/foundation.dart';
import '../states/timer_state.dart';

class TimerRepository extends ChangeNotifier {
  TimerState _state;

  TimerRepository({
    required Duration initialDuration,
    int pomodoros = 4,
  }) : _state = TimerState(
          currentDuration: initialDuration,
          originalDuration: initialDuration,
          pomodoros: pomodoros,
        );

  TimerState getTimerState() => _state;

  void updateState(TimerState newState) {
    _state = newState;
    notifyListeners();
  }
}
