import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/question_model.dart';

class QuestionService {
  static const Duration _timeout = Duration(seconds: 15);

  Future<List<QuestionModel>> getQuestions() async {
    final response = await http
        .get(
          Uri.parse('${AppConstants.baseUrl}${AppConstants.questionsEndpoint}'),
          headers: {'Content-Type': 'application/json'},
        )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Handle both {"questions": [...]} and direct array responses
      List<dynamic> list;
      if (data is List) {
        list = data;
      } else if (data['questions'] != null) {
        list = data['questions'];
      } else if (data['records'] != null) {
        list = data['records'];
      } else if (data['data'] != null) {
        list = data['data'];
      } else {
        list = [];
      }
      return list.map((q) => QuestionModel.fromJson(q)).toList();
    } else {
      throw Exception('Failed to load questions: ${response.statusCode}');
    }
  }
}
