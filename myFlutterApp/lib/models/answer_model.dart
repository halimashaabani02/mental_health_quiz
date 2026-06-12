class AnswerModel {
  final int id;
  final int questionId;
  final String answerText;
  final int? score;

  AnswerModel({
    required this.id,
    required this.questionId,
    required this.answerText,
    this.score,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      questionId: int.tryParse(json['question_id'].toString()) ?? 0,
      answerText: json['answer_text'] ?? json['answer'] ?? '',
      score: json['score'] != null ? int.tryParse(json['score'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_id': questionId,
      'answer_text': answerText,
      'score': score,
    };
  }
}
