import 'package:flutter/material.dart';
import 'package:geddy_done/data/repositories/timer/time_repository_remote.dart';
import 'package:geddy_done/data/services/notifications/break_timer_end_notification.dart';
import 'package:geddy_done/data/services/notifications/notification_service.dart';
import 'package:geddy_done/data/services/notifications/pomodoro_timer_end_notification.dart';
import 'package:geddy_done/ui/pomodoro/viewmodels/timer_viewmodel.dart';
import 'package:geddy_done/ui/pomodoro/widgets/pomodoro_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeddyDone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PomodoroScreen(
        pomodoroViewModel: TimerViewmodel(
          pomodoroRepository: TimerRepositoryRemote(
            notification: PomodoroTimerEndNotification(
              notificationService: NotificationService(),
            ),
          ),
        ),
        timerViewModel: TimerViewmodel(
          pomodoroRepository: TimerRepositoryRemote(
            notification: BreakTimerEndNotification(
              notificationService: NotificationService(),
            ),
            duration: Duration(minutes: 5),
          ),
        ),
      ),
    );
  }
}
