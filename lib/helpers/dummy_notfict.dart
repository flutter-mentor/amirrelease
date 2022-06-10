import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DummyNotfict {
  static final notfict = FlutterLocalNotificationsPlugin();
  static final onNotfications = BehaviorSubject<String?>();

  static Future showNotfict({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    notfict.show(id, title, body, await notfictDetails(), payload: payload);
  }

  static Future showSchadNotfict({
    required int id,
    required String title,
    required String body,
    // required String payload,
    required DateTime time,
  }) async {
    notfict.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      await notfictDetails(),
      // payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future showSchadNotfictDaily({
    required int id,
    required String title,
    required String body,
    required String payload,
    required int h,
    int? m,
    int? s,
  }) async {
    notfict.zonedSchedule(
        id, title, body, schadDaily(Time(h, m!, s!)), await notfictDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static Future showSchadNotfictWeekly(
      {required int id,
      required String title,
      required String body,
      required String payload,
      required int h,
      int? m,
      int? s,
      List<int>? days}) async {
    notfict.zonedSchedule(id, title, body,
        schadWeekly(time: Time(h, m!, s!), days: days!), await notfictDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  static tz.TZDateTime schadDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final schadDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return schadDate.isBefore(now)
        ? schadDate.add(Duration(days: 1))
        : schadDate;
  }

  static tz.TZDateTime schadWeekly(
      {required Time time, required List<int> days}) {
    tz.TZDateTime schadDate = schadDaily(time);
    while (!days.contains(schadDate.weekday)) {
      schadDate = schadDate.add(Duration(days: 1));
    }
    return schadDate;
  }

  static Future notfictDetails() async {
    final sound = 'alarm.wav';
    return NotificationDetails(
      android: AndroidNotificationDetails('medtrackchannelid', 'medTracker',
          importance: Importance.high,
          sound: RawResourceAndroidNotificationSound(sound.split('.').first)
          // 'channel describtion',
          ),
      iOS: IOSNotificationDetails(
        sound: sound,
      ),
    );
  }

  static Future initializetimezone() async {
    tz.initializeTimeZones();
  }

  static Future init({bool initSchudealed = false}) async {
    final details = await notfict.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotfications.add(details.payload);
    }

    final ios = IOSInitializationSettings();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(
      android: android,
      iOS: ios,
    );
    await notfict.initialize(settings, onSelectNotification: (payload) async {
      onNotfications.add(payload);
    });
    if (initSchudealed) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static void cancel(int id) {
    notfict.cancel(id);
  }

  static void cancelAll() {
    notfict.cancelAll();
  }
}
