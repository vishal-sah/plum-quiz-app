import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/quiz_provider.dart';
import '../feedback/feedback_screen.dart';

class QuizScreen extends ConsumerWidget {
  final String topic;

  const QuizScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    if (quizState.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Quiz - $topic')),
        body: const Center(child: Text('No questions available')),
      );
    }

    final currentQuestion = quizState.questions[quizState.currentQuestionIndex];
    final isLastQuestion =
        quizState.currentQuestionIndex == quizState.questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz - $topic'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${quizState.currentQuestionIndex + 1}/${quizState.questions.length}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  currentQuestion.question,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ...currentQuestion.options.map((option) {
              final isSelected =
                  quizState.answers[quizState.currentQuestionIndex] == option;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    quizNotifier.setAnswer(
                      quizState.currentQuestionIndex,
                      option,
                    );
                    Future.delayed(const Duration(milliseconds: 200), () {
                      if (isLastQuestion) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FeedbackScreen(
                              topic: topic,
                              answers: quizState.answers,
                              questions: quizState.questions,
                            ),
                          ),
                        );
                      } else {
                        quizNotifier.nextQuestion();
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 18,
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
