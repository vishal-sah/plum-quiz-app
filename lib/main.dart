import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:plum_quiz_app/screens/topic_selection/topic_selection_screen.dart';
import 'package:plum_quiz_app/theme/app_theme.dart';

final apiKey = ""; // Add your Gemini API key here

void main() {
  /// Initialize Gemini with your API key
  Gemini.init(apiKey: apiKey);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Quiz App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: TopicSelectionScreen(),
    );
  }
}
