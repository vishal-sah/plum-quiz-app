class PromptBuilder {
  static String quizPrompt(String topic) {
    return '''
Generate 5 multiple-choice questions on the topic "$topic". 
Respond ONLY with JSON in the format:
{
  "questions": [
    {
      "question": "string",
      "options": ["string1", "string2", "string3", "string4"],
      "answer": "one of the options"
    }
  ]
}
    ''';
  }

  static String feedbackPrompt(String topic, Map<String, dynamic> attempts) {
    return '''
The user completed a quiz on "$topic".
Here are their attempts: $attempts
Provide a short, encouraging feedback message (50 words max).
Respond ONLY with JSON in the format:
{
  "message": "your feedback message"
}
    ''';
  }
}
