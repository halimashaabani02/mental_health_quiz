import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/session_manager.dart';
import '../utils/api_response.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  late SessionManager _sessionManager;

  ApiResponse<bool> _registerState = ApiResponse.idle();
  ApiResponse<bool> _loginState = ApiResponse.idle();

  ApiResponse<bool> get registerState => _registerState;
  ApiResponse<bool> get loginState => _loginState;

  Future<void> init() async {
    _sessionManager = await SessionManager.getInstance();
  }

  bool get isLoggedIn => _sessionManager.isLoggedIn();
  String? get username => _sessionManager.getUsername();
  int? get userId => _sessionManager.getUserId();

  Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    _registerState = ApiResponse.loading();
    notifyListeners();

    final result = await _authService.register(
      username: username,
      email: email,
      password: password,
    );

    final success = result['success'] == true || result['status'] == true;
    if (success) {
      _registerState = ApiResponse.success(true);
    } else {
      _registerState = ApiResponse.error(
          result['message'] ?? 'Registration failed. Please try again.');
    }
    notifyListeners();
    return success;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _loginState = ApiResponse.loading();
    notifyListeners();

    final result = await _authService.login(email: email, password: password);
    final success = result['success'] == true || result['status'] == true;

    if (success && result['user_model'] != null) {
      final user = result['user_model'];
      await _sessionManager.saveUserSession(
        userId: user.id ?? 0,
        username: user.username,
        email: user.email,
        role: user.role ?? 'user',
        token: user.token,
      );
      _loginState = ApiResponse.success(true);
    } else {
      _loginState = ApiResponse.error(
          result['message'] ?? 'Invalid credentials. Please try again.');
    }
    notifyListeners();
    return success;
  }

  Future<void> logout() async {
    await _sessionManager.clearSession();
    _loginState = ApiResponse.idle();
    _registerState = ApiResponse.idle();
    notifyListeners();
  }

  void resetStates() {
    _registerState = ApiResponse.idle();
    _loginState = ApiResponse.idle();
    notifyListeners();
  }
}
