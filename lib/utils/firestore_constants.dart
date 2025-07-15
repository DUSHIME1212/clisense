class FirestoreCollections {
  static const String users = 'users';
  static const String forecasts = 'forecasts';
  static const String alerts = 'alerts';
  static const String cropAdvice = 'crop_advice';
  static const String feedback = 'feedback';
  static const String extensionVisits = 'extension_visits';
}

class StorageBuckets {
  static const String userProfilePictures = 'user_profile_pictures';
  static const String alertImages = 'alert_images';
  static const String cropImages = 'crop_images';
}

class DocumentFields {
  // User fields
  static const String fullName = 'fullName';
  static const String phone = 'phone';
  static const String gender = 'gender';
  static const String age = 'age';
  static const String country = 'country';
  static const String region = 'region';
  static const String district = 'district';
  static const String farmSize = 'farmSize';
  static const String mainCrops = 'mainCrops';
  static const String plantingSeason = 'plantingSeason';
  static const String preferredChannels = 'preferredChannels';
  static const String createdAt = 'createdAt';
  
  // Forecast fields
  static const String locationId = 'locationId';
  static const String date = 'date';
  static const String rainfallMm = 'rainfall_mm';
  static const String temperatureMax = 'temperature_max';
  static const String temperatureMin = 'temperature_min';
  static const String forecastConfidence = 'forecastConfidence';
  static const String issuedAt = 'issuedAt';
  
  // Alert fields
  static const String type = 'type';
  static const String severity = 'severity';
  static const String predictedDate = 'predictedDate';
  static const String confidence = 'confidence';
  static const String actions = 'actions';
  static const String sentTo = 'sentTo';
  
  // Crop Advice fields
  static const String crop = 'crop';
  static const String zone = 'zone';
  static const String month = 'month';
  static const String strategy = 'strategy';
  static const String validatedBy = 'validatedBy';
  static const String source = 'source';
  
  // Feedback fields
  static const String userId = 'userId';
  static const String feedbackType = 'feedbackType';
  static const String message = 'message';
  static const String rating = 'rating';
  static const String submittedAt = 'submittedAt';
  
  // Extension Visit fields
  static const String officerName = 'officerName';
  static const String notes = 'notes';
  static const String visitDate = 'visitDate';
}

class AlertTypes {
  static const String flood = 'Flood Warning';
  static const String drought = 'Drought Warning';
  static const String pest = 'Pest Alert';
  static const String disease = 'Disease Alert';
  static const String weather = 'Weather Alert';
  static const String other = 'Other';
}

class SeverityLevels {
  static const String low = 'Low';
  static const String medium = 'Medium';
  static const String high = 'High';
  static const String critical = 'Critical';
}

class FeedbackTypes {
  static const String forecastAccuracy = 'Forecast Accuracy';
  static const String alertUsefulness = 'Alert Usefulness';
  static const String cropAdviceQuality = 'Crop Advice Quality';
  static const String appUsability = 'App Usability';
  static const String bugReport = 'Bug Report';
  static const String featureRequest = 'Feature Request';
  static const String other = 'Other';
}
