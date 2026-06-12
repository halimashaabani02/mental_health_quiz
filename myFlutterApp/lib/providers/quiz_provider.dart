import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/question_service.dart';
import '../services/submission_service.dart';
import '../utils/api_response.dart';

class QuizProvider extends ChangeNotifier {
  final QuestionService _questionService = QuestionService();
  final SubmissionService _submissionService = SubmissionService();

  List<QuestionModel> _questions = [];
  int _currentIndex = 0;
  Map<int, int> _selectedAnswers = {}; // questionId -> answerId

  ApiResponse<List<QuestionModel>> _questionsState = ApiResponse.idle();
  ApiResponse<Map<String, dynamic>> _submitState = ApiResponse.idle();

  List<QuestionModel> get questions => _questions;
  int get currentIndex => _currentIndex;
  Map<int, int> get selectedAnswers => _selectedAnswers;
  ApiResponse<List<QuestionModel>> get questionsState => _questionsState;
  ApiResponse<Map<String, dynamic>> get submitState => _submitState;

  QuestionModel? get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentIndex] : null;

  bool get isLastQuestion => _currentIndex == _questions.length - 1;
  bool get isFirstQuestion => _currentIndex == 0;
  int get answeredCount => _selectedAnswers.length;
  double get progress =>
      _questions.isEmpty ? 0 : (_currentIndex + 1) / _questions.length;

  Future<void> loadQuestions() async {
    _questionsState = ApiResponse.loading();
    _questions = [];
    _currentIndex = 0;
    _selectedAnswers = {};
    notifyListeners();

    try {
      final questions = await _questionService.getQuestions();
      _questions = questions;
      _questionsState = ApiResponse.success(questions);
    } catch (e) {
      _questionsState = ApiResponse.error(e.toString().replaceAll('Exception: ', ''));
    }
    notifyListeners();
  }

  void selectAnswer(int questionId, int answerId) {
    _selectedAnswers[questionId] = answerId;
    notifyListeners();
  }

  int? getSelectedAnswer(int questionId) => _selectedAnswers[questionId];

  void goToNext() {
    if (!isLastQuestion) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void goToPrevious() {
    if (!isFirstQuestion) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  Future<bool> submitQuiz(int userId) async {
    _submitState = ApiResponse.loading();
    notifyListeners();

    try {
      final answers = _selectedAnswers.entries
          .map((e) => {'question_id': e.key, 'answer_id': e.value})
          .toList();

      final result = await _submissionService.submitQuiz(
        userId: userId,
        answers: answers,
      );

      final success = result['success'] == true || result['status'] == true;
      if (success) {
        _submitState = ApiResponse.success(result);
        notifyListeners();
        return true;
      } else {
        _submitState = ApiResponse.error(result['message'] ?? 'Submission failed.');
        notifyListeners();
        return false;
      }
    } catch (e) {
      _submitState = ApiResponse.error(e.toString().replaceAll('Exception: ', ''));
      notifyListeners();
      return false;
    }
  }

  void resetQuiz() {
    _currentIndex = 0;
    _selectedAnswers = {};
    _submitState = ApiResponse.idle();
    notifyListeners();
  }
}
