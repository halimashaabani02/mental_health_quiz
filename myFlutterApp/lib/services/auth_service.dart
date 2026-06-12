import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/user_model.dart';

class AuthService {
  static const Duration _timeout = Duration(seconds: 15);

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('${AppConstants.baseUrl}${AppConstants.registerEndpoint}'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': username,
              'email': email,
              'password': password,
            }),
          )
          .timeout(_timeout);

      final data = jsonDecode(response.body);
      return data;
    } on Exception catch (e) {
      return {'success': false, 'message': _parseException(e)};
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('${AppConstants.baseUrl}${AppConstants.loginEndpoint}'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(_timeout);

      final data = jsonDecode(response.body);
      if ((data['success'] == true || data['status'] == true) && data['user'] != null) {
        data['user_model'] = UserModel.fromJson(data['user']);
      }
      return data;
    } on Exception catch (e) {
      return {'success': false, 'message': _parseException(e)};
    }
  }

  String _parseException(Exception e) {
    final msg = e.toString();
    if (msg.contains('SocketException') || msg.contains('Connection refused')) {
      return 'Cannot connect to server. Please check your connection.';
    }
    if (msg.contains('TimeoutException')) {
      return 'Request timed out. Please try again.';
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
