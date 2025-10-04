import 'package:flutter/material.dart';
import '../loading/loading_screen.dart';

class TopicSelectionScreen extends StatelessWidget {
  final List<String> topics = [
    "Accounting",
    "Achievement",
    "Adventure",
    "AI",
    "Algorithms",
    "Anthropology",
    "Architecture",
    "Art",
    "Astronomy",
    "Astrophysics",
    "Biographies",
    "Biology",
    "Blockchain",
    "Business Management",
    "Cardiology",
    "Chemistry",
    "Chess",
    "Climate Change",
    "Cloud Computing",
    "Comedy",
    "Computer Networks",
    "Computer Vision",
    "Cooking",
    "Creativity",
    "Critical Thinking",
    "Cricket",
    "Cryptocurrency",
    "Data Science",
    "Data Structures",
    "Database Systems",
    "Dance",
    "Deep Learning",
    "Dentistry",
    "Design",
    "DevOps",
    "DIY",
    "Economics",
    "Education",
    "Electrical Engineering",
    "Engineering",
    "Entrepreneurship",
    "Ethics",
    "Finance",
    "Fitness",
    "Flutter",
    "Food Science",
    "Football",
    "Game Development",
    "Gardening",
    "Genetics",
    "Geography",
    "Graphic Design",
    "History",
    "Hockey",
    "Human Resources",
    "Immunology",
    "Innovation",
    "Internet of Things",
    "Java",
    "JavaScript",
    "Journalism",
    "Kotlin",
    "Languages",
    "Law",
    "Leadership",
    "Learning",
    "Literature",
    "Machine Learning",
    "Marketing",
    "Mathematics",
    "Mechanical Engineering",
    "Meditation",
    "Medicine",
    "Microbiology",
    "Mindfulness",
    "Motivation",
    "Music",
    "Narcotics",
    "Neuroscience",
    "Nutrition",
    "Operating Systems",
    "Pathology",
    "Personal Development",
    "Philosophy",
    "Photography",
    "Physics",
    "Poetry",
    "Political Science",
    "Productivity",
    "Programming",
    "Psychology",
    "Python",
    "React",
    "Relationships",
    "Robotics",
    "Ruby",
    "Rust",
    "Sleep Science",
    "Software Engineering",
    "Space Exploration",
    "Sports",
    "SQL",
    "Stress Management",
    "Swift",
    "Technology Policy",
    "Tennis",
    "Travel",
    "UI/UX Design",
    "Wellness",
    "Yoga",
  ];

  TopicSelectionScreen({super.key});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Topic")),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      labelText: "Enter custom topic",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final customTopic = textController.text.trim();
                    if (customTopic.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoadingScreen(topic: customTopic),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a topic.")),
                      );
                    }
                  },
                  child: Text("Start Quiz"),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: topics.length,
              itemBuilder: (_, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      topics[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoadingScreen(topic: topics[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
