import 'package:geddy_done/data/services/notifications/notification_service.dart';
import 'package:geddy_done/data/services/notifications/pomodoro_notification.dart';

class BreakTimerEndNotification extends PomodoroNotification {
  final NotificationService _notificationService;

  BreakTimerEndNotification({required NotificationService notificationService})
      : _notificationService = notificationService;

  @override
  Future<void> notify() async {
    await _notificationService.showNotification(
      'Break is over',
      'Your break is over. Time to get back to work!',
    );
  }
}
