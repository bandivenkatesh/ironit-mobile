import 'package:shared_preferences/shared_preferences.dart';

import 'preference_keys.dart';

/// Application preferences service.
/// Centralized abstraction for SharedPreferences access.
/// Do NOT access SharedPreferences directly from UI components.
class AppPreferences {
  static late SharedPreferences _prefs;

  /// Initialize preferences service.
  /// Must be called before any other methods.
  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Authentication Preferences

  /// Get authentication token
  static String? getAuthToken() => _prefs.getString(PreferenceKeys.authToken);

  /// Set authentication token
  static Future<bool> setAuthToken(String token) =>
      _prefs.setString(PreferenceKeys.authToken, token);

  /// Remove authentication token
  static Future<bool> removeAuthToken() =>
      _prefs.remove(PreferenceKeys.authToken);

  /// Check if user is logged in
  static bool getIsLoggedIn() =>
      _prefs.getBool(PreferenceKeys.isLoggedIn) ?? false;

  /// Set logged in status
  static Future<bool> setIsLoggedIn(bool value) =>
      _prefs.setBool(PreferenceKeys.isLoggedIn, value);

  /// Check if user is guest
  static bool getIsGuest() => _prefs.getBool(PreferenceKeys.isGuest) ?? false;

  /// Set guest status
  static Future<bool> setIsGuest(bool value) =>
      _prefs.setBool(PreferenceKeys.isGuest, value);

  /// Get user ID
  static String? getUserId() => _prefs.getString(PreferenceKeys.userId);

  /// Set user ID
  static Future<bool> setUserId(String userId) =>
      _prefs.setString(PreferenceKeys.userId, userId);

  /// Get user name
  static String? getUserName() => _prefs.getString(PreferenceKeys.userName);

  /// Set user name
  static Future<bool> setUserName(String userName) =>
      _prefs.setString(PreferenceKeys.userName, userName);

  /// Get user email
  static String? getUserEmail() => _prefs.getString(PreferenceKeys.userEmail);

  /// Set user email
  static Future<bool> setUserEmail(String userEmail) =>
      _prefs.setString(PreferenceKeys.userEmail, userEmail);

  /// Get remember me preference
  static bool getRememberMe() =>
      _prefs.getBool(PreferenceKeys.rememberMe) ?? false;

  /// Set remember me preference
  static Future<bool> setRememberMe(bool value) =>
      _prefs.setBool(PreferenceKeys.rememberMe, value);

  // Onboarding Preferences

  /// Check if onboarding is complete
  static bool getOnboardingComplete() =>
      _prefs.getBool(PreferenceKeys.onboardingComplete) ?? false;

  /// Set onboarding complete status
  static Future<bool> setOnboardingComplete(bool value) =>
      _prefs.setBool(PreferenceKeys.onboardingComplete, value);

  // App Settings

  /// Get theme mode
  static String? getThemeMode() => _prefs.getString(PreferenceKeys.themeMode);

  /// Set theme mode
  static Future<bool> setThemeMode(String mode) =>
      _prefs.setString(PreferenceKeys.themeMode, mode);

  /// Check if this is first launch
  static bool getIsFirstLaunch() =>
      _prefs.getBool(PreferenceKeys.firstLaunch) ?? true;

  /// Set first launch status
  static Future<bool> setIsFirstLaunch(bool value) =>
      _prefs.setBool(PreferenceKeys.firstLaunch, value);

  /// Get last app version
  static String? getLastVersion() =>
      _prefs.getString(PreferenceKeys.lastVersion);

  /// Set last app version
  static Future<bool> setLastVersion(String version) =>
      _prefs.setString(PreferenceKeys.lastVersion, version);

  // General Methods

  /// Clear all authentication-related preferences
  static Future<void> clearAuthPreferences() async {
    await _prefs.remove(PreferenceKeys.authToken);
    await _prefs.remove(PreferenceKeys.isLoggedIn);
    await _prefs.remove(PreferenceKeys.isGuest);
    await _prefs.remove(PreferenceKeys.userId);
    await _prefs.remove(PreferenceKeys.userName);
    await _prefs.remove(PreferenceKeys.userEmail);
    await _prefs.remove(PreferenceKeys.rememberMe);
  }

  /// Clear all preferences (use with caution)
  static Future<bool> clearAll() => _prefs.clear();

  /// Check if a key exists
  static bool containsKey(String key) => _prefs.containsKey(key);

  /// Remove a specific key
  static Future<bool> remove(String key) => _prefs.remove(key);
}
