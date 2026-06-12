class AppConstants {
  // Change this to your server's IP address when testing on a physical device
  // Use 10.0.2.2 for Android emulator (maps to localhost)
  static const String baseUrl = 'http://10.0.2.2/mental_health_quiz/api';
  // static const String baseUrl = 'http://localhost/mental_health_quiz/api';

  // Auth endpoints
  static const String registerEndpoint = '/auth/register.php';
  static const String loginEndpoint = '/auth/login.php';

  // Questions endpoints
  static const String questionsEndpoint = '/questions/read.php';

  // Submissions endpoints
  static const String submitQuizEndpoint = '/submissions/create.php';
  static const String submissionsListEndpoint = '/submissions/read.php';
  static const String submissionDetailEndpoint = '/submissions/read_one.php';

  // SharedPreferences Keys
  static const String keyUserId = 'user_id';
  static const String keyUsername = 'username';
  static const String keyEmail = 'email';
  static const String keyUserRole = 'user_role';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyToken = 'token';

  // App Strings
  static const String appName = 'MindCheck';
  static const String appTagline = 'Your mental wellness companion';
}
