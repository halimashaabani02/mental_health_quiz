class SubmissionModel {
  final int id;
  final int userId;
  final int score;
  final String feedback;
  final String submittedAt;

  SubmissionModel({
    required this.id,
    required this.userId,
    required this.score,
    required this.feedback,
    required this.submittedAt,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      userId: int.tryParse(json['user_id'].toString()) ?? 0,
      score: int.tryParse(json['score'].toString()) ?? 0,
      feedback: json['feedback'] ?? '',
      submittedAt: json['submitted_at'] ?? json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'score': score,
      'feedback': feedback,
      'submitted_at': submittedAt,
    };
  }
}
