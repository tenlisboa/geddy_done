import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geddy_done/data/repositories/pomodoro/pomodoro_repository.dart';
import 'package:geddy_done/domain/models/pomodoro.dart';
import 'package:geddy_done/utils/command.dart';
import 'package:geddy_done/utils/result.dart';

class PomodoroViewmodel extends ChangeNotifier {
  late Command0<void> start;
  late Command0<void> pause;
  late Command0<void> reset;

  late Pomodoro _pomodoro;
  StreamSubscription<Pomodoro>? _subscription;

  final PomodoroRepository _pomodoroRepository;

  PomodoroViewmodel({
    required PomodoroRepository pomodoroRepository,
  }) : _pomodoroRepository = pomodoroRepository {
    start = Command0(_start);
    pause = Command0(_pause);
    reset = Command0(_reset);

    _pomodoro = _pomodoroRepository.currentState;
    _subscribeToStateChanges();
  }

  void _subscribeToStateChanges() {
    _subscription = _pomodoroRepository.stateStream.listen((state) {
      _pomodoro = state;
      notifyListeners();
    });
  }

  Pomodoro get pomodoro => _pomodoro;

  Future<Result<void>> _start() async {
    return _pomodoroRepository.start();
  }

  Future<Result<void>> _pause() async {
    return _pomodoroRepository.pause();
  }

  Future<Result<void>> _reset() async {
    return _pomodoroRepository.reset();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _pomodoroRepository.dispose();
    super.dispose();
  }
}
