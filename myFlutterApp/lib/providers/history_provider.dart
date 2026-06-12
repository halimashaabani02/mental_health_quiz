import 'package:flutter/material.dart';
import '../models/submission_model.dart';
import '../models/submission_detail_model.dart';
import '../services/submission_service.dart';
import '../utils/api_response.dart';

class HistoryProvider extends ChangeNotifier {
  final SubmissionService _submissionService = SubmissionService();

  ApiResponse<List<SubmissionModel>> _submissionsState = ApiResponse.idle();
  ApiResponse<List<SubmissionDetailModel>> _detailState = ApiResponse.idle();

  ApiResponse<List<SubmissionModel>> get submissionsState => _submissionsState;
  ApiResponse<List<SubmissionDetailModel>> get detailState => _detailState;

  Future<void> loadSubmissions(int userId) async {
    _submissionsState = ApiResponse.loading();
    notifyListeners();

    try {
      final submissions = await _submissionService.getUserSubmissions(userId);
      _submissionsState = ApiResponse.success(submissions);
    } catch (e) {
      _submissionsState = ApiResponse.error(e.toString().replaceAll('Exception: ', ''));
    }
    notifyListeners();
  }

  Future<void> loadSubmissionDetails(int submissionId) async {
    _detailState = ApiResponse.loading();
    notifyListeners();

    try {
      final details = await _submissionService.getSubmissionDetails(submissionId);
      _detailState = ApiResponse.success(details);
    } catch (e) {
      _detailState = ApiResponse.error(e.toString().replaceAll('Exception: ', ''));
    }
    notifyListeners();
  }
}
