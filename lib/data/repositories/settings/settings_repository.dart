import 'package:geddy_done/utils/result.dart';

abstract class SettingsRepository {
  Future<Result<void>> setPomodoroDuration(Duration duration);
  Future<Result<void>> setShortBreakDuration(Duration duration);
  Future<Result<Duration>> getPomodoroDuration();
  Future<Result<Duration>> getShortBreakDuration();
}
