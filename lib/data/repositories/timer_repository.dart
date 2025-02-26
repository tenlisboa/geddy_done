import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geddy_done/data/services/notification_service.dart';

class TimerRepository extends ChangeNotifier {
  bool isRunning = false;
  Duration pomodoroDuration;
  int pomodoros;

  final NotificationService notificationService = NotificationService();

  late Duration originalPomodoroDuration;

  TimerRepository({
    required this.pomodoroDuration,
    this.pomodoros = 4,
  }) {
    originalPomodoroDuration = pomodoroDuration;
  }

  Future<void> startTimer() async {
    isRunning = true;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      if (!isRunning) {
        timer.cancel();
        resetTimer();
        notifyListeners();
        return;
      }
      if (pomodoroDuration.inSeconds == 0) {
        timer.cancel();
        isRunning = false;
        resetTimer();
        await notificationService.showNotification('Pomodoro Complete',
            'You have completed a pomodoro. Take a break!');
      } else {
        pomodoroDuration -= const Duration(seconds: 1);
      }

      notifyListeners();
    });
  }

  void stopTimer() {
    isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    pomodoroDuration = originalPomodoroDuration;
    notifyListeners();
  }
}
