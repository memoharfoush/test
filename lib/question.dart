// To parse this JSON data, do
//
//     final question = questionFromMap(jsonString);
//Question questionFromMap(String str) => Question.fromMap(json.decode(str));

//String questionToMap(Question data) => json.encode(data.toMap());

class Question {
  int? queId;
  final String? queText;
  final String? quesM;
  final int? quizId;

  Question({
    required this.queId,
    required this.queText,
    required this.quesM,
    required this.quizId,
  });

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        queId: json["queId"],
        queText: json["queText"],
        quesM: json["quesM"],
        quizId: json["quizId"],
      );

  Map<String, dynamic> toMap() => {
        "queId": queId,
        "queText": queText,
        "quesM": quesM,
        "quizId": quizId,
      };
}
