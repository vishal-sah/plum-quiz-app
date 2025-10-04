import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final String? selectedAnswer;
  final Function(String) onSelect;

  const QuestionCard({
    super.key,
    required this.question,
    required this.options,
    required this.selectedAnswer,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(16),
      shadowColor: Colors.black54,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 18),
            ...options.map((opt) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    onSelect(opt); // Immediately go to next question
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedAnswer == opt
                          ? Colors.blue.shade50
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: selectedAnswer == opt
                          ? [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ]
                          : [],
                      border: Border.all(
                        color: selectedAnswer == opt
                            ? Colors.blue
                            : Colors.grey.shade300,
                        width: selectedAnswer == opt ? 2 : 1,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        opt,
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedAnswer == opt
                              ? Colors.blue
                              : Colors.black87,
                        ),
                      ),
                      trailing: selectedAnswer == opt
                          ? Icon(Icons.check_circle, color: Colors.blue)
                          : null,
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
