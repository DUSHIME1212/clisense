import 'package:cloud_firestore/cloud_firestore.dart';

class ForecastModel {
  final String id;
  final String locationId;
  final DateTime date;
  final double rainfallMm;
  final double temperatureMax;
  final double temperatureMin;
  final double forecastConfidence;
  final DateTime issuedAt;

  ForecastModel({
    required this.id,
    required this.locationId,
    required this.date,
    required this.rainfallMm,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.forecastConfidence,
    DateTime? issuedAt,
  }) : issuedAt = issuedAt ?? DateTime.now();

  // Convert model to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'locationId': locationId,
      'date': Timestamp.fromDate(date),
      'rainfall_mm': rainfallMm,
      'temperature_max': temperatureMax,
      'temperature_min': temperatureMin,
      'forecastConfidence': forecastConfidence,
      'issuedAt': Timestamp.fromDate(issuedAt),
    };
  }

  // Create model from Firestore document
  factory ForecastModel.fromMap(String id, Map<String, dynamic> map) {
    return ForecastModel(
      id: id,
      locationId: map['locationId'] ?? '',
      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      rainfallMm: (map['rainfall_mm'] ?? 0.0).toDouble(),
      temperatureMax: (map['temperature_max'] ?? 0.0).toDouble(),
      temperatureMin: (map['temperature_min'] ?? 0.0).toDouble(),
      forecastConfidence: (map['forecastConfidence'] ?? 0.0).toDouble(),
      issuedAt: (map['issuedAt'] as Timestamp?)?.toDate(),
    );
  }
}
