import 'package:flutter_riverpod/legacy.dart';
import '../core/models/question.dart';

class QuizState {
  final List<Question> questions;
  final Map<int, String> answers;
  final int currentQuestionIndex;

  QuizState({
    this.questions = const [],
    this.answers = const {},
    this.currentQuestionIndex = 0,
  });

  QuizState copyWith({
    List<Question>? questions,
    Map<int, String>? answers,
    int? currentQuestionIndex,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier() : super(QuizState());

  void setQuestions(List<Question> questions) {
    state = state.copyWith(
      questions: questions,
      currentQuestionIndex: 0,
      answers: {},
    );
  }

  void setAnswer(int questionIndex, String answer) {
    final newAnswers = Map<int, String>.from(state.answers);
    newAnswers[questionIndex] = answer;
    state = state.copyWith(answers: newAnswers);
  }

  void nextQuestion() {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
      );
    }
  }

  void previousQuestion() {
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
      );
    }
  }

  void reset() {
    state = QuizState();
  }
}

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>((ref) {
  return QuizNotifier();
});
