import 'package:geddy_done/contracts/timer_notification.dart';
import 'package:geddy_done/data/services/notification_service.dart';

class BreakTimerEndNotification extends TimerNotification {
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
