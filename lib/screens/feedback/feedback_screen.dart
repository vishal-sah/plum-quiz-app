import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/ai/ai_service.dart';
import '../../core/models/question.dart';
import '../../core/models/feedback.dart';

class FeedbackScreen extends ConsumerStatefulWidget {
  final String topic;
  final Map<int, String> answers;
  final List<Question> questions;

  const FeedbackScreen({
    super.key,
    required this.topic,
    required this.answers,
    required this.questions,
  });

  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  FeedbackModel? feedback;

  @override
  void initState() {
    super.initState();
    _getFeedback();
  }

  Future<void> _getFeedback() async {
    final aiService = AIService();
    final score = widget.answers.entries
        .where((entry) => widget.questions[entry.key].answer == entry.value)
        .length;

    final attempts = {
      "score": "$score/${widget.questions.length}",
      "answers": widget.answers,
    };

    final result = await aiService.generateFeedback(widget.topic, attempts);
    setState(() {
      feedback = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final score = widget.answers.entries
        .where((entry) => widget.questions[entry.key].answer == entry.value)
        .length;

    return Scaffold(
      appBar: AppBar(title: Text("Your Feedback")),
      body: Center(
        child: feedback == null
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Score: $score / ${widget.questions.length}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      feedback!.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
