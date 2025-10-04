import 'dart:convert';
import 'package:flutter_gemini/flutter_gemini.dart';
import '../models/question.dart';
import '../models/feedback.dart';
import 'prompt_builder.dart';

class AIService {
  final Gemini gemini = Gemini.instance;

  Future<List<Question>> generateQuestions(String topic) async {
    try {
      final prompt = PromptBuilder.quizPrompt(topic);

      final response = await gemini.text(prompt);
      final content = response?.output ?? '';

      if (content.isEmpty) {
        throw Exception('Empty response from Gemini');
      }

      // Clean the response to extract JSON
      String jsonString = content.trim();

      // Remove markdown code blocks if present
      if (jsonString.startsWith('```json')) {
        jsonString = jsonString.substring(7);
      }
      if (jsonString.startsWith('```')) {
        jsonString = jsonString.substring(3);
      }
      if (jsonString.endsWith('```')) {
        jsonString = jsonString.substring(0, jsonString.length - 3);
      }

      final jsonData = json.decode(jsonString.trim());
      final questionsJson = jsonData['questions'] as List;

      return questionsJson
          .map(
            (q) => Question(
              question: q['question'] as String,
              options: List<String>.from(q['options']),
              answer: q['answer'] as String,
            ),
          )
          .toList();
    } catch (e) {
      print('Error generating questions: $e');
      // Return fallback questions if API fails
      return _getFallbackQuestions(topic);
    }
  }

  Future<FeedbackModel> generateFeedback(
    String topic,
    Map<String, dynamic> attempts,
  ) async {
    try {
      final prompt = PromptBuilder.feedbackPrompt(topic, attempts);

      final response = await gemini.text(prompt);
      final content = response?.output ?? '';

      if (content.isEmpty) {
        return FeedbackModel(
          message: 'Great effort! Keep learning and improving.',
        );
      }

      // Clean the response to extract JSON
      String jsonString = content.trim();

      // Remove markdown code blocks if present
      if (jsonString.startsWith('```json')) {
        jsonString = jsonString.substring(7);
      }
      if (jsonString.startsWith('```')) {
        jsonString = jsonString.substring(3);
      }
      if (jsonString.endsWith('```')) {
        jsonString = jsonString.substring(0, jsonString.length - 3);
      }

      final jsonData = json.decode(jsonString.trim());
      return FeedbackModel(message: jsonData['message'] as String);
    } catch (e) {
      print('Error generating feedback: $e');
      return FeedbackModel(
        message: 'Great effort! Keep learning and improving.',
      );
    }
  }

  List<Question> _getFallbackQuestions(String topic) {
    // Provide fallback questions for when API fails
    return [
      Question(
        question: "What is a key concept in $topic?",
        options: ["Option A", "Option B", "Option C", "Option D"],
        answer: "Option A",
      ),
      Question(
        question: "Which statement about $topic is correct?",
        options: ["Statement 1", "Statement 2", "Statement 3", "Statement 4"],
        answer: "Statement 1",
      ),
      Question(
        question: "What is the most important aspect of $topic?",
        options: ["Aspect 1", "Aspect 2", "Aspect 3", "Aspect 4"],
        answer: "Aspect 1",
      ),
    ];
  }
}
