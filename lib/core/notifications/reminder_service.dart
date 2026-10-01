import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'reminder_plan.dart';

/// Lokale tägliche Lern-Erinnerungen über `flutter_local_notifications`.
///
/// Ohne Server: Die Erinnerungen der nächsten Tage werden auf dem Gerät
/// eingeplant und bei jedem App-Start bzw. nach jeder Runde neu berechnet.
/// Auf dem Web und solange [init] nicht lief (z. B. in Widget-Tests) ist
/// alles ein No-op - das Plugin wird dann nie aufgerufen.
class ReminderService {
  ReminderService._();

  static final instance = ReminderService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  static bool get supported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  /// Einmal in `main()` aufrufen. Fragt noch nicht nach Berechtigung.
  Future<void> init() async {
    if (!supported || _ready) return;
    try {
      tzdata.initializeTimeZones();
      try {
        final info = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(info.identifier));
      } catch (_) {
        tz.setLocalLocation(tz.getLocation('Europe/Berlin'));
      }
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          ),
        ),
      );
      _ready = true;
    } catch (e) {
      debugPrint('Erinnerungen nicht verfügbar: $e');
    }
  }

  /// Fragt die Berechtigung an (iOS, Android 13+). `true` = erlaubt.
  /// Auf nicht unterstützten Plattformen `false`.
  Future<bool> requestPermission() async {
    if (!_ready) return false;
    try {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (android != null) {
        return await android.requestNotificationsPermission() ?? false;
      }
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      if (ios != null) {
        return await ios.requestPermissions(
              alert: true,
              badge: false,
              sound: true,
            ) ??
            false;
      }
    } catch (e) {
      debugPrint('Berechtigung fehlgeschlagen: $e');
    }
    return false;
  }

  /// Ersetzt alle geplanten Erinnerungen durch [plan].
  /// Aufrufe laufen nacheinander, damit sich zwei Neuplanungen nicht mischen.
  Future<void> apply(List<PlannedReminder> plan) {
    if (!_ready) return Future.value();
    return _queue = _queue.then((_) => _apply(plan));
  }

  Future<void> _queue = Future.value();

  Future<void> _apply(List<PlannedReminder> plan) async {
    try {
      await _plugin.cancelAll();
      for (final r in plan) {
        await _plugin.zonedSchedule(
          id: r.id,
          scheduledDate: tz.TZDateTime(
            tz.local,
            r.at.year,
            r.at.month,
            r.at.day,
            r.at.hour,
          ),
          title: r.title,
          body: r.body,
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              'daily_reminder',
              'Tägliche Erinnerung',
              channelDescription: 'Bit erinnert dich ans Lernen',
              importance: Importance.defaultImportance,
              priority: Priority.defaultPriority,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          // Inexakt: braucht keine SCHEDULE_EXACT_ALARM-Berechtigung.
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      }
    } catch (e) {
      debugPrint('Erinnerungen planen fehlgeschlagen: $e');
    }
  }
}
