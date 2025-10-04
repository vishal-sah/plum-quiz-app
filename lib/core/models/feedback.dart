class FeedbackModel {
  final String message;

  FeedbackModel({required this.message});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(message: json['message'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
