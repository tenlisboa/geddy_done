import 'package:flutter/material.dart';
import 'package:geddy_done/data/repositories/pomodoro/pomodoro_repository_remote.dart';
import 'package:geddy_done/data/services/notifications/notification_service.dart';
import 'package:geddy_done/data/services/notifications/pomodoro_timer_end_notification.dart';
import 'package:geddy_done/ui/pomodoro/viewmodels/pomodoro_viewmodel.dart';
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
        viewModel: PomodoroViewmodel(
          pomodoroRepository: PomodoroRepositoryRemote(
            notification: PomodoroTimerEndNotification(
              notificationService: NotificationService(),
            ),
          ),
        ),
      ),
    );
  }
}
