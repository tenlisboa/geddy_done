import 'package:geddy_done/contracts/timer_notification.dart';
import 'package:geddy_done/data/services/notification_service.dart';

class PomodoroTimerEndNotification extends TimerNotification {
  final NotificationService _notificationService;

  PomodoroTimerEndNotification(
      {required NotificationService notificationService})
      : _notificationService = notificationService;

  @override
  Future<void> notify() async {
    await _notificationService.showNotification(
      'Pomodoro Complete',
      'You have completed a pomodoro. Take a break!',
    );
  }
}
