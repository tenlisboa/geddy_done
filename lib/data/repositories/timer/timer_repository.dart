import 'package:geddy_done/domain/models/pomodoro.dart';
import 'package:geddy_done/utils/result.dart';

abstract class TimerRepository {
  Stream<Pomodoro> get stateStream;
  Future<Result<void>> start();
  Future<Result<void>> pause();
  Future<Result<void>> reset();

  void dispose();

  Pomodoro get currentState;
}
