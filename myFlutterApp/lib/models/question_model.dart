import 'answer_model.dart';

class QuestionModel {
  final int id;
  final String questionText;
  final List<AnswerModel> answers;

  QuestionModel({
    required this.id,
    required this.questionText,
    required this.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    List<AnswerModel> answerList = [];
    if (json['answers'] != null) {
      answerList = List<AnswerModel>.from(
        (json['answers'] as List).map((a) => AnswerModel.fromJson(a)),
      );
    }
    return QuestionModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      questionText: json['question_text'] ?? json['question'] ?? '',
      answers: answerList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_text': questionText,
      'answers': answers.map((a) => a.toJson()).toList(),
    };
  }
}
