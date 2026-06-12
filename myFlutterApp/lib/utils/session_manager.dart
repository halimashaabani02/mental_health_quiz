import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class SessionManager {
  static SessionManager? _instance;
  static SharedPreferences? _prefs;

  SessionManager._();

  static Future<SessionManager> getInstance() async {
    _instance ??= SessionManager._();
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<void> saveUserSession({
    required int userId,
    required String username,
    required String email,
    required String role,
    String? token,
  }) async {
    await _prefs!.setInt(AppConstants.keyUserId, userId);
    await _prefs!.setString(AppConstants.keyUsername, username);
    await _prefs!.setString(AppConstants.keyEmail, email);
    await _prefs!.setString(AppConstants.keyUserRole, role);
    await _prefs!.setBool(AppConstants.keyIsLoggedIn, true);
    if (token != null) {
      await _prefs!.setString(AppConstants.keyToken, token);
    }
  }

  Future<void> clearSession() async {
    await _prefs!.clear();
  }

  bool isLoggedIn() {
    return _prefs!.getBool(AppConstants.keyIsLoggedIn) ?? false;
  }

  int? getUserId() {
    return _prefs!.getInt(AppConstants.keyUserId);
  }

  String? getUsername() {
    return _prefs!.getString(AppConstants.keyUsername);
  }

  String? getEmail() {
    return _prefs!.getString(AppConstants.keyEmail);
  }

  String? getUserRole() {
    return _prefs!.getString(AppConstants.keyUserRole);
  }

  String? getToken() {
    return _prefs!.getString(AppConstants.keyToken);
  }
}
