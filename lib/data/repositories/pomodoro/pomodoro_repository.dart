import 'package:geddy_done/domain/models/pomodoro.dart';
import 'package:geddy_done/utils/result.dart';

abstract class PomodoroRepository {
  Future<Result<Pomodoro>> start(Function(Pomodoro) modificationCallback);
  Future<Result<void>> pause();

  Pomodoro get state;
}
