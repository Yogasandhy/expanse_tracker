class AppConstants {
  // App Information
  static const String appName = 'Expense Tracker';
  static const String appVersion = '1.0.0';
  
  // Storage Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyPinCode = 'pin_code';
  static const String keyIsFirstTime = 'is_first_time';
  static const String keyBudgets = 'budgets';
  
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration splashDuration = Duration(seconds: 2);
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 12.0;
  
  // Chart Constants
  static const int maxPieChartSections = 6;
  static const int maxBarChartItems = 12;
  
  // PIN Constants
  static const int pinLength = 4;
  static const int maxPinAttempts = 3;
}
