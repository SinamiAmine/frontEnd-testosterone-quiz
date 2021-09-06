class Question {
  final String? id;
  final String? question;
  final List<dynamic>? reponses;

  const Question({
    this.id,
    this.question,
    this.reponses,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json["_id"] as String?,
      question: json['question'] as String?,
      reponses: json['reponses'] as List<dynamic>?,
    );
  }
}
