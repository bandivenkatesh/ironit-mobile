/// Centralized preference keys for the application.
/// All SharedPreferences keys should be defined here.
class PreferenceKeys {
  // Authentication
  static const String authToken = 'auth_token';
  static const String isLoggedIn = 'is_logged_in';
  static const String isGuest = 'is_guest';
  static const String userId = 'user_id';
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String rememberMe = 'remember_me';

  // Onboarding
  static const String onboardingComplete = 'onboarding_complete';

  // App Settings
  static const String themeMode = 'theme_mode';
  static const String firstLaunch = 'first_launch';
  static const String lastVersion = 'last_version';

  // Feature Flags
  static const String featureAnalytics = 'feature_analytics';
  static const String featureNotifications = 'feature_notifications';

  // Cache
  static const String cacheExpiry = 'cache_expiry';
}
