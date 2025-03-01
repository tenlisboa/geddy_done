import 'package:geddy_done/data/services/notifications/notification_service.dart';
import 'package:geddy_done/data/services/notifications/pomodoro_notification.dart';

class PomodoroTimerEndNotification extends PomodoroNotification {
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
