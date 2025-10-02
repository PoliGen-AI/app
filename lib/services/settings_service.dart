import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends ChangeNotifier {
  static const String _isDarkThemeKey = 'isDarkTheme';
  static const String _analyticsEnabledKey = 'analyticsEnabled';
  static const String _marketingEnabledKey = 'marketingEnabled';
  static const String _essentialCookiesKey = 'essentialCookies';
  static const String _functionalCookiesKey = 'functionalCookies';
  static const String _performanceCookiesKey = 'performanceCookies';
  static const String _marketingCookiesKey = 'marketingCookies';
  static const String _imageQualityKey = 'imageQuality';
  static const String _autoSaveKey = 'autoSave';
  static const String _showTipsKey = 'showTips';

  // Theme settings
  bool _isDarkTheme = true;

  // Privacy settings
  bool _analyticsEnabled = true;
  bool _marketingEnabled = false;

  // Cookie settings
  bool _essentialCookies = true;
  bool _functionalCookies = true;
  bool _performanceCookies = false;
  bool _marketingCookies = false;

  // General settings
  String _imageQuality = 'Alta';
  bool _autoSave = true;
  bool _showTips = true;

  // For testing purposes - expose private fields
  @visibleForTesting
  bool get isDarkThemeForTesting => _isDarkTheme;

  @visibleForTesting
  bool get essentialCookiesForTesting => _essentialCookies;

  @visibleForTesting
  bool get functionalCookiesForTesting => _functionalCookies;

  @visibleForTesting
  bool get performanceCookiesForTesting => _performanceCookies;

  @visibleForTesting
  bool get marketingCookiesForTesting => _marketingCookies;

  // Getters
  bool get isDarkTheme => _isDarkTheme;
  bool get analyticsEnabled => _analyticsEnabled;
  bool get marketingEnabled => _marketingEnabled;
  bool get essentialCookies => _essentialCookies;
  bool get functionalCookies => _functionalCookies;
  bool get performanceCookies => _performanceCookies;
  bool get marketingCookies => _marketingCookies;
  String get imageQuality => _imageQuality;
  bool get autoSave => _autoSave;
  bool get showTips => _showTips;

  // Theme mode getter
  ThemeMode get themeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  /// Initialize settings by loading from SharedPreferences
  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      _isDarkTheme = prefs.getBool(_isDarkThemeKey) ?? true;
      _analyticsEnabled = prefs.getBool(_analyticsEnabledKey) ?? true;
      _marketingEnabled = prefs.getBool(_marketingEnabledKey) ?? false;
      _essentialCookies = prefs.getBool(_essentialCookiesKey) ?? true;
      _functionalCookies = prefs.getBool(_functionalCookiesKey) ?? true;
      _performanceCookies = prefs.getBool(_performanceCookiesKey) ?? false;
      _marketingCookies = prefs.getBool(_marketingCookiesKey) ?? false;
      _imageQuality = prefs.getString(_imageQualityKey) ?? 'Alta';
      _autoSave = prefs.getBool(_autoSaveKey) ?? true;
      _showTips = prefs.getBool(_showTipsKey) ?? true;
    } catch (e) {
      // Fallback to default values if SharedPreferences fails
      print('SharedPreferences not available, using default values: $e');
    }

    notifyListeners();
  }

  /// Update theme setting
  Future<void> updateTheme(bool isDark) async {
    _isDarkTheme = isDark;
    try {
      await _saveBool(_isDarkThemeKey, _isDarkTheme);
    } catch (e) {
      print('Failed to save theme setting: $e');
    }
    notifyListeners();
  }

  /// Update privacy settings
  Future<void> updateAnalytics(bool enabled) async {
    _analyticsEnabled = enabled;
    try {
      await _saveBool(_analyticsEnabledKey, _analyticsEnabled);
    } catch (e) {
      print('Failed to save analytics setting: $e');
    }
    notifyListeners();
  }

  Future<void> updateMarketing(bool enabled) async {
    _marketingEnabled = enabled;
    try {
      await _saveBool(_marketingEnabledKey, _marketingEnabled);
    } catch (e) {
      print('Failed to save marketing setting: $e');
    }
    notifyListeners();
  }

  /// Update cookie settings
  Future<void> updateEssentialCookies(bool enabled) async {
    _essentialCookies = enabled;
    try {
      await _saveBool(_essentialCookiesKey, _essentialCookies);
    } catch (e) {
      print('Failed to save essential cookies setting: $e');
    }
    notifyListeners();
  }

  Future<void> updateFunctionalCookies(bool enabled) async {
    _functionalCookies = enabled;
    try {
      await _saveBool(_functionalCookiesKey, _functionalCookies);
    } catch (e) {
      print('Failed to save functional cookies setting: $e');
    }
    notifyListeners();
  }

  Future<void> updatePerformanceCookies(bool enabled) async {
    _performanceCookies = enabled;
    try {
      await _saveBool(_performanceCookiesKey, _performanceCookies);
    } catch (e) {
      print('Failed to save performance cookies setting: $e');
    }
    notifyListeners();
  }

  Future<void> updateMarketingCookies(bool enabled) async {
    _marketingCookies = enabled;
    try {
      await _saveBool(_marketingCookiesKey, _marketingCookies);
    } catch (e) {
      print('Failed to save marketing cookies setting: $e');
    }
    notifyListeners();
  }

  /// Update general settings
  Future<void> updateImageQuality(String quality) async {
    _imageQuality = quality;
    try {
      await _saveString(_imageQualityKey, _imageQuality);
    } catch (e) {
      print('Failed to save image quality setting: $e');
    }
    notifyListeners();
  }

  Future<void> updateAutoSave(bool enabled) async {
    _autoSave = enabled;
    try {
      await _saveBool(_autoSaveKey, _autoSave);
    } catch (e) {
      print('Failed to save auto save setting: $e');
    }
    notifyListeners();
  }

  Future<void> updateShowTips(bool enabled) async {
    _showTips = enabled;
    try {
      await _saveBool(_showTipsKey, _showTips);
    } catch (e) {
      print('Failed to save show tips setting: $e');
    }
    notifyListeners();
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    _isDarkTheme = true;
    _analyticsEnabled = true;
    _marketingEnabled = false;
    _essentialCookies = true;
    _functionalCookies = true;
    _performanceCookies = false;
    _marketingCookies = false;
    _imageQuality = 'Alta';
    _autoSave = true;
    _showTips = true;

    try {
      await _saveAllSettings();
    } catch (e) {
      print('Failed to save settings after reset: $e');
    }
    notifyListeners();
  }

  /// Save all settings to SharedPreferences
  Future<void> _saveAllSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_isDarkThemeKey, _isDarkTheme);
    await prefs.setBool(_analyticsEnabledKey, _analyticsEnabled);
    await prefs.setBool(_marketingEnabledKey, _marketingEnabled);
    await prefs.setBool(_essentialCookiesKey, _essentialCookies);
    await prefs.setBool(_functionalCookiesKey, _functionalCookies);
    await prefs.setBool(_performanceCookiesKey, _performanceCookies);
    await prefs.setBool(_marketingCookiesKey, _marketingCookies);
    await prefs.setString(_imageQualityKey, _imageQuality);
    await prefs.setBool(_autoSaveKey, _autoSave);
    await prefs.setBool(_showTipsKey, _showTips);
  }

  /// Helper methods for saving individual settings
  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// Check if cookies are enabled (at least essential cookies)
  bool get cookiesEnabled => _essentialCookies;

  /// Check if analytics cookies are enabled
  bool get analyticsCookiesEnabled => _essentialCookies && _performanceCookies;

  /// Check if marketing cookies are enabled
  bool get marketingCookiesEnabled => _essentialCookies && _marketingCookies;

  /// Check if functional cookies are enabled
  bool get functionalCookiesEnabled => _essentialCookies && _functionalCookies;
}
