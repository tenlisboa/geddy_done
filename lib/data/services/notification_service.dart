import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  late final FlutterLocalNotificationsPlugin plugin;

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal() {
    plugin = FlutterLocalNotificationsPlugin();
    _initialize();
  }

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestSoundPermission: true,
    notificationCategories: [
      DarwinNotificationCategory(
        'timer',
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain('timer_end', 'Timer End'),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      ),
    ],
  );

  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  Future<void> _initialize() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await plugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'timer',
      'timer_end',
      importance: Importance.max,
      priority: Priority.high,
      category: AndroidNotificationCategory.alarm,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      threadIdentifier: 'timer',
      presentAlert: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await plugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
