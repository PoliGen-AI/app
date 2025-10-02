import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poligen_app/services/settings_service.dart';

void main() {
  group('SettingsService', () {
    late SettingsService settingsService;

    setUp(() {
      settingsService = SettingsService();
    });

    test('should initialize with default values', () {
      expect(settingsService.isDarkTheme, true);
      expect(settingsService.analyticsEnabled, true);
      expect(settingsService.marketingEnabled, false);
      expect(settingsService.essentialCookies, true);
      expect(settingsService.functionalCookies, true);
      expect(settingsService.performanceCookies, false);
      expect(settingsService.marketingCookies, false);
      expect(settingsService.imageQuality, 'Alta');
      expect(settingsService.autoSave, true);
      expect(settingsService.showTips, true);
    });

    test('should return correct theme mode', () {
      expect(settingsService.themeMode, ThemeMode.dark);
      expect(settingsService.isDarkThemeForTesting, true);
    });

    test('should check cookie combinations correctly', () {
      // Test default values
      expect(settingsService.essentialCookiesForTesting, true);
      expect(settingsService.functionalCookiesForTesting, true);
      expect(settingsService.performanceCookiesForTesting, false);
      expect(settingsService.marketingCookiesForTesting, false);

      expect(settingsService.cookiesEnabled, true);
      expect(settingsService.functionalCookiesEnabled, true);
      expect(settingsService.analyticsCookiesEnabled, false);
      expect(settingsService.marketingCookiesEnabled, false);
    });

    test('should be singleton', () {
      final instance1 = SettingsService();
      final instance2 = SettingsService();

      expect(instance1, equals(instance2));
    });
  });
}
