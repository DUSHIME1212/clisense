import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String fullName;
  final String phone;
  final String gender;
  final int age;
  final String country;
  final String region;
  final String district;
  final double farmSize;
  final List<String> mainCrops;
  final String plantingSeason;
  final List<String> preferredChannels;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.gender,
    required this.age,
    required this.country,
    required this.region,
    required this.district,
    required this.farmSize,
    required this.mainCrops,
    required this.plantingSeason,
    required this.preferredChannels,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert model to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phone': phone,
      'gender': gender,
      'age': age,
      'country': country,
      'region': region,
      'district': district,
      'farmSize': farmSize,
      'mainCrops': mainCrops,
      'plantingSeason': plantingSeason,
      'preferredChannels': preferredChannels,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create model from Firestore document
  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age'] ?? 0,
      country: map['country'] ?? '',
      region: map['region'] ?? '',
      district: map['district'] ?? '',
      farmSize: (map['farmSize'] ?? 0.0).toDouble(),
      mainCrops: List<String>.from(map['mainCrops'] ?? []),
      plantingSeason: map['plantingSeason'] ?? '',
      preferredChannels: List<String>.from(map['preferredChannels'] ?? []),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
