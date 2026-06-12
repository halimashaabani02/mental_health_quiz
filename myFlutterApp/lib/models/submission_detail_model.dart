class SubmissionDetailModel {
  final int submissionId;
  final int questionId;
  final String questionText;
  final int answerId;
  final String answerText;
  final int? score;

  SubmissionDetailModel({
    required this.submissionId,
    required this.questionId,
    required this.questionText,
    required this.answerId,
    required this.answerText,
    this.score,
  });

  factory SubmissionDetailModel.fromJson(Map<String, dynamic> json) {
    return SubmissionDetailModel(
      submissionId: int.tryParse(json['submission_id'].toString()) ?? 0,
      questionId: int.tryParse(json['question_id'].toString()) ?? 0,
      questionText: json['question_text'] ?? json['question'] ?? '',
      answerId: int.tryParse(json['answer_id'].toString()) ?? 0,
      answerText: json['answer_text'] ?? json['answer'] ?? '',
      score: json['score'] != null ? int.tryParse(json['score'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'submission_id': submissionId,
      'question_id': questionId,
      'question_text': questionText,
      'answer_id': answerId,
      'answer_text': answerText,
      'score': score,
    };
  }
}
