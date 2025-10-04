class Question {
  final String question;
  final List<String> options;
  final String answer;

  Question({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] as String,
      options: List<String>.from(json['options']),
      answer: json['answer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'question': question, 'options': options, 'answer': answer};
  }
}
