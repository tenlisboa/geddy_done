import 'package:flutter/material.dart';
import 'package:geddy_done/data/repositories/settings/settings_repository.dart';
import 'package:geddy_done/utils/command.dart';
import 'package:geddy_done/utils/result.dart';

class SettingsViewmodel extends ChangeNotifier {
  SettingsViewmodel({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository {
    getPomodoroDuration = Command0(_getPomodoroDuration)..execute();
    getShortBreakDuration = Command0(_getShortBreakDuration)..execute();
    setPomodoroDuration = Command1(_setPomodoroDuration);
    setShortBreakDuration = Command1(_setShortBreakDuration);
  }

  final SettingsRepository _settingsRepository;

  late Command0<Duration> getPomodoroDuration;
  late Command0<Duration> getShortBreakDuration;
  late Command1<void, Duration> setPomodoroDuration;
  late Command1<void, Duration> setShortBreakDuration;

  Duration _pomodoroDuration = const Duration(minutes: 25);
  Duration get pomodoroDuration => _pomodoroDuration;

  Duration _shortBreakDuration = const Duration(minutes: 5);
  Duration get shortBreakDuration => _shortBreakDuration;

  Future<Result<void>> _setPomodoroDuration(Duration duration) async {
    _pomodoroDuration = duration;
    _settingsRepository.setPomodoroDuration(duration);
    notifyListeners();

    return Result.ok(null);
  }

  Future<Result<void>> _setShortBreakDuration(Duration duration) async {
    _shortBreakDuration = duration;
    _settingsRepository.setShortBreakDuration(duration);
    notifyListeners();

    return Result.ok(null);
  }

  Future<Result<Duration>> _getPomodoroDuration() async {
    var result = await _settingsRepository.getPomodoroDuration();
    _pomodoroDuration = result.asOk.value;
    notifyListeners();

    return result;
  }

  Future<Result<Duration>> _getShortBreakDuration() async {
    var result = await _settingsRepository.getShortBreakDuration();
    _shortBreakDuration = result.asOk.value;
    notifyListeners();

    return result;
  }
}
