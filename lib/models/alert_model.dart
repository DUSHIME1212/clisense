import 'package:cloud_firestore/cloud_firestore.dart';

class AlertModel {
  final String id;
  final String type;
  final String region;
  final String severity;
  final DateTime predictedDate;
  final double confidence;
  final List<String> actions;
  final List<String> sentTo;
  final DateTime createdAt;

  AlertModel({
    required this.id,
    required this.type,
    required this.region,
    required this.severity,
    required this.predictedDate,
    required this.confidence,
    required this.actions,
    required this.sentTo,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert model to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'region': region,
      'severity': severity,
      'predictedDate': Timestamp.fromDate(predictedDate),
      'confidence': confidence,
      'actions': actions,
      'sentTo': sentTo,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create model from Firestore document
  factory AlertModel.fromMap(String id, Map<String, dynamic> map) {
    return AlertModel(
      id: id,
      type: map['type'] ?? '',
      region: map['region'] ?? '',
      severity: map['severity'] ?? 'Medium',
      predictedDate: (map['predictedDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      confidence: (map['confidence'] ?? 0.0).toDouble(),
      actions: List<String>.from(map['actions'] ?? []),
      sentTo: List<String>.from(map['sentTo'] ?? []),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
