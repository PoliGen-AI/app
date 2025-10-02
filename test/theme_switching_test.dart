import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poligen_app/services/settings_service.dart';

void main() {
  group('Theme Switching', () {
    late SettingsService settingsService;

    setUp(() {
      settingsService = SettingsService();
    });

    test('should return dark theme mode by default', () {
      expect(settingsService.themeMode, ThemeMode.dark);
      expect(settingsService.isDarkTheme, true);
    });

    test('should switch to light theme mode', () async {
      // Change to light theme
      await settingsService.updateTheme(false);

      expect(settingsService.themeMode, ThemeMode.light);
      expect(settingsService.isDarkTheme, false);
    });

    test('should switch back to dark theme mode', () async {
      // First switch to light
      await settingsService.updateTheme(false);
      expect(settingsService.themeMode, ThemeMode.light);

      // Then switch back to dark
      await settingsService.updateTheme(true);

      expect(settingsService.themeMode, ThemeMode.dark);
      expect(settingsService.isDarkTheme, true);
    });

    test('should notify listeners when theme changes', () async {
      bool listenerCalled = false;

      settingsService.addListener(() {
        listenerCalled = true;
      });

      await settingsService.updateTheme(false);

      expect(listenerCalled, true);
    });
  });
}
