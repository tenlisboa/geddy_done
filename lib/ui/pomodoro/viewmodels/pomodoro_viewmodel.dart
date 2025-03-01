import 'package:flutter/material.dart';
import 'package:geddy_done/data/repositories/pomodoro/pomodoro_repository.dart';
import 'package:geddy_done/domain/models/pomodoro.dart';
import 'package:geddy_done/utils/command.dart';
import 'package:geddy_done/utils/result.dart';

class PomodoroViewmodel extends ChangeNotifier {
  late Command0<Pomodoro> start;
  late Command0<void> pause;

  late Pomodoro _pomodoro;

  final PomodoroRepository _pomodoroRepository;

  PomodoroViewmodel({
    required PomodoroRepository pomodoroRepository,
  }) : _pomodoroRepository = pomodoroRepository {
    start = Command0(_start);
    pause = Command0(_pause);

    _pomodoro = _pomodoroRepository.state;
  }

  Pomodoro get pomodoro => _pomodoro;

  Future<Result<Pomodoro>> _start() async {
    var result = await _pomodoroRepository.start((Pomodoro state) {
      _pomodoro = state;
      notifyListeners();
    });

    return Result.ok(result.asOk.value);
  }

  Future<Result<void>> _pause() async {
    await _pomodoroRepository.pause();
    return Result.ok(null);
  }
}
