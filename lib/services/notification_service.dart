import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() => _notificationService;
  NotificationService._internal();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    try {
      InitializationSettings initializationSettings;

      if (Platform.isMacOS) {
        const DarwinInitializationSettings initializationSettingsDarwin =
            DarwinInitializationSettings();
        initializationSettings = const InitializationSettings(
          macOS: initializationSettingsDarwin,
        );
      } else if (Platform.isLinux) {
        const LinuxInitializationSettings initializationSettingsLinux =
            LinuxInitializationSettings(defaultActionName: 'Abrir');
        initializationSettings = const InitializationSettings(
          linux: initializationSettingsLinux,
        );
      } else if (Platform.isWindows) {
        // For Windows, try with empty initialization first
        initializationSettings = const InitializationSettings();
        if (kDebugMode) {
          debugPrint('🔧 Attempting Windows notification initialization...');
        }
      } else {
        // For other platforms
        initializationSettings = const InitializationSettings();
      }

      final bool? result = await _plugin.initialize(initializationSettings);

      if (result == true) {
        _initialized = true;
        if (kDebugMode) {
          debugPrint(
            '✅ NotificationService initialized on ${Platform.operatingSystem}',
          );
        }
      } else {
        if (kDebugMode) {
          debugPrint('❌ NotificationService failed to initialize');
        }
        // Still mark as initialized to allow fallback behavior
        _initialized = true;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error initializing NotificationService: $e');
        if (Platform.isWindows) {
          debugPrint(
            'ℹ️  This may be expected in debug builds - MSIX packages should work',
          );
        }
      }
      // Mark as initialized to allow fallback behavior
      _initialized = true;
    }
  }

  Future<void> showTrayNotification() async {
    if (!_initialized) {
      if (kDebugMode) {
        debugPrint('❌ showTrayNotification called before init');
      }
      return;
    }

    try {
      if (Platform.isWindows) {
        // Windows-specific notification approach
        await _showWindowsNotification();
      } else {
        // macOS and Linux approach
        NotificationDetails? details;

        if (Platform.isMacOS) {
          details = const NotificationDetails(
            macOS: DarwinNotificationDetails(),
          );
        } else if (Platform.isLinux) {
          details = const NotificationDetails(
            linux: LinuxNotificationDetails(),
          );
        }

        await _plugin.show(
          0,
          'PoliGen-AI',
          'PoliGen-AI está rodando na bandeja do sistema.',
          details,
        );

        if (kDebugMode) {
          debugPrint(
            '✅ Tray notification shown on ${Platform.operatingSystem}',
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error showing tray notification: $e');

        if (Platform.isWindows) {
          debugPrint(
            'ℹ️  Windows: If you\'re running from MSIX, notifications should work',
          );
          debugPrint('ℹ️  If running debug build, this error is expected');
          debugPrint(
            'ℹ️  Check Windows notification settings if MSIX notifications don\'t appear',
          );
        }

        debugPrint(
          '📢 FALLBACK: PoliGen-AI minimized to system tray successfully',
        );
      }
    }
  }

  Future<void> _showWindowsNotification() async {
    if (kDebugMode) {
      debugPrint('🔧 Attempting Windows notification...');
    }

    try {
      // Try multiple approaches for Windows notifications

      // Approach 1: Basic notification with no details
      await _plugin.show(
        0,
        'PoliGen-AI',
        'PoliGen-AI está rodando na bandeja do sistema.',
        null,
      );

      if (kDebugMode) {
        debugPrint('✅ Windows notification shown successfully!');
      }
    } catch (e1) {
      if (kDebugMode) {
        debugPrint('❌ Windows notification approach 1 failed: $e1');
      }

      try {
        // Approach 2: Try with basic NotificationDetails
        const details = NotificationDetails();
        await _plugin.show(
          0,
          'PoliGen-AI',
          'PoliGen-AI está rodando na bandeja do sistema.',
          details,
        );

        if (kDebugMode) {
          debugPrint('✅ Windows notification shown with basic details!');
        }
      } catch (e2) {
        if (kDebugMode) {
          debugPrint('❌ Windows notification approach 2 failed: $e2');
          debugPrint('ℹ️  Possible causes:');
          debugPrint('   • App not installed via MSIX (running debug build?)');
          debugPrint('   • Windows notifications disabled in system settings');
          debugPrint(
            '   • App needs to be launched from Start Menu (not .exe)',
          );
          debugPrint('   • Windows Focus Assist is blocking notifications');
        }

        // Re-throw to trigger the main catch block
        throw e2;
      }
    }
  }
}
