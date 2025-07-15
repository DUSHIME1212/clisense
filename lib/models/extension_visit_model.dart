import 'package:cloud_firestore/cloud_firestore.dart';

class ExtensionVisitModel {
  final String id;
  final String officerName;
  final String userId;
  final String region;
  final String notes;
  final DateTime visitDate;
  final DateTime createdAt;

  ExtensionVisitModel({
    required this.id,
    required this.officerName,
    required this.userId,
    required this.region,
    required this.notes,
    required this.visitDate,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert model to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'officerName': officerName,
      'userId': userId,
      'region': region,
      'notes': notes,
      'visitDate': Timestamp.fromDate(visitDate),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create model from Firestore document
  factory ExtensionVisitModel.fromMap(String id, Map<String, dynamic> map) {
    return ExtensionVisitModel(
      id: id,
      officerName: map['officerName'] ?? '',
      userId: map['userId'] ?? '',
      region: map['region'] ?? '',
      notes: map['notes'] ?? '',
      visitDate: (map['visitDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
