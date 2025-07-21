// lib/src/core/constants/app_strings.dart

/// A class to hold all application-wide string constants.
/// This helps in centralizing text, making it easier for localization and consistency.
class AppStrings {
  static const String appName = 'EPMS Flutter';
  static const String unknownRouteError = 'Error: Unknown route!';
  static const String noInternetConnection = 'No Internet Connection. Please check your network settings.';
  static const String serverFailureMessage = 'Server Error. Please try again later.';
  static const String cacheFailureMessage = 'Failed to retrieve data from local storage.';
  static const String genericErrorMessage = 'Something went wrong. Please try again.';

  // Common UI texts
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String loading = 'Loading...';
  static const String submit = 'Submit';

  // Add more strings as your app grows
  static const String welcomeMessage = 'Welcome to EPMS!';
  static const String loginButton = 'Login';
  static const String logoutButton = 'Logout';
}
