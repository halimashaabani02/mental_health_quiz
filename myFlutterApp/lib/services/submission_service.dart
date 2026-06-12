import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/submission_model.dart';
import '../models/submission_detail_model.dart';

class SubmissionService {
  static const Duration _timeout = Duration(seconds: 15);

  /// Submit quiz answers. answers = [{"question_id": 1, "answer_id": 3}, ...]
  Future<Map<String, dynamic>> submitQuiz({
    required int userId,
    required List<Map<String, int>> answers,
  }) async {
    final response = await http
        .post(
          Uri.parse('${AppConstants.baseUrl}${AppConstants.submitQuizEndpoint}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'user_id': userId,
            'answers': answers,
          }),
        )
        .timeout(_timeout);

    return jsonDecode(response.body);
  }

  Future<List<SubmissionModel>> getUserSubmissions(int userId) async {
    final response = await http
        .get(
          Uri.parse(
              '${AppConstants.baseUrl}${AppConstants.submissionsListEndpoint}?user_id=$userId'),
          headers: {'Content-Type': 'application/json'},
        )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> list;
      if (data is List) {
        list = data;
      } else if (data['submissions'] != null) {
        list = data['submissions'];
      } else if (data['records'] != null) {
        list = data['records'];
      } else if (data['data'] != null) {
        list = data['data'];
      } else {
        list = [];
      }
      return list.map((s) => SubmissionModel.fromJson(s)).toList();
    } else {
      throw Exception('Failed to load submissions');
    }
  }

  Future<List<SubmissionDetailModel>> getSubmissionDetails(int submissionId) async {
    final response = await http
        .get(
          Uri.parse(
              '${AppConstants.baseUrl}${AppConstants.submissionDetailEndpoint}?id=$submissionId'),
          headers: {'Content-Type': 'application/json'},
        )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> list;
      if (data is List) {
        list = data;
      } else if (data['details'] != null) {
        list = data['details'];
      } else if (data['records'] != null) {
        list = data['records'];
      } else if (data['data'] != null) {
        list = data['data'];
      } else {
        list = [];
      }
      return list.map((d) => SubmissionDetailModel.fromJson(d)).toList();
    } else {
      throw Exception('Failed to load submission details');
    }
  }
}
