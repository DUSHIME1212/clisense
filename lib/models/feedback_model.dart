import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String id;
  final String userId;
  final String feedbackType;
  final String message;
  final int rating;
  final DateTime submittedAt;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.feedbackType,
    required this.message,
    required this.rating,
    DateTime? submittedAt,
  }) : submittedAt = submittedAt ?? DateTime.now();

  // Convert model to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'feedbackType': feedbackType,
      'message': message,
      'rating': rating,
      'submittedAt': Timestamp.fromDate(submittedAt),
    };
  }

  // Create model from Firestore document
  factory FeedbackModel.fromMap(String id, Map<String, dynamic> map) {
    return FeedbackModel(
      id: id,
      userId: map['userId'] ?? '',
      feedbackType: map['feedbackType'] ?? 'General',
      message: map['message'] ?? '',
      rating: map['rating'] ?? 0,
      submittedAt: (map['submittedAt'] as Timestamp?)?.toDate(),
    );
  }
}
