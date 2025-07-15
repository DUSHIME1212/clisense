import 'package:cloud_firestore/cloud_firestore.dart';

class CropAdviceModel {
  final String id;
  final String crop;
  final String zone;
  final String month;
  final String strategy;
  final String validatedBy;
  final String source;
  final DateTime createdAt;

  CropAdviceModel({
    required this.id,
    required this.crop,
    required this.zone,
    required this.month,
    required this.strategy,
    required this.validatedBy,
    required this.source,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert model to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'crop': crop,
      'zone': zone,
      'month': month,
      'strategy': strategy,
      'validatedBy': validatedBy,
      'source': source,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create model from Firestore document
  factory CropAdviceModel.fromMap(String id, Map<String, dynamic> map) {
    return CropAdviceModel(
      id: id,
      crop: map['crop'] ?? '',
      zone: map['zone'] ?? '',
      month: map['month'] ?? '',
      strategy: map['strategy'] ?? '',
      validatedBy: map['validatedBy'] ?? '',
      source: map['source'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
