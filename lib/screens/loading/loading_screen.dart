import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plum_quiz_app/core/ai/ai_service.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  final String topic;
  const LoadingScreen({super.key, required this.topic});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  final AIService aiService = AIService();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await aiService.generateQuestions(widget.topic);
      if (questions.isNotEmpty) {
        // ✅ safely access notifier here
        ref.read(quizProvider.notifier).setQuestions(questions);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => QuizScreen(topic: widget.topic)),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading questions: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch quiz. Please retry.")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Generating quiz on ${widget.topic}..."),
          ],
        ),
      ),
    );
  }
}
