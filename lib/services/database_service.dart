import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../models/forecast_model.dart';
import '../models/alert_model.dart';
import '../models/crop_advice_model.dart';
import '../models/feedback_model.dart';
import '../models/extension_visit_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User Collection Reference
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference _forecastsCollection = FirebaseFirestore.instance.collection('forecasts');
  final CollectionReference _alertsCollection = FirebaseFirestore.instance.collection('alerts');
  final CollectionReference _cropAdviceCollection = FirebaseFirestore.instance.collection('crop_advice');
  final CollectionReference _feedbackCollection = FirebaseFirestore.instance.collection('feedback');
  final CollectionReference _extensionVisitsCollection = FirebaseFirestore.instance.collection('extension_visits');

  // User Operations
  Future<void> createUser(UserModel user) async {
    return await _usersCollection.doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await _usersCollection.doc(userId).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    return await _usersCollection.doc(user.id).update(user.toMap());
  }

  // Forecast Operations
  Stream<List<ForecastModel>> getForecastsByLocation(String locationId) {
    return _forecastsCollection
        .where('locationId', isEqualTo: locationId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ForecastModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList());
  }

  // Alert Operations
  Stream<List<AlertModel>> getAlertsByRegion(String region) {
    return _alertsCollection
        .where('region', isEqualTo: region)
        .orderBy('predictedDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => AlertModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList());
  }

  // Crop Advice Operations
  Stream<List<CropAdviceModel>> getCropAdvice(String crop, String zone) {
    return _cropAdviceCollection
        .where('crop', isEqualTo: crop)
        .where('zone', isEqualTo: zone)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => CropAdviceModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList());
  }

  // Feedback Operations
  Future<void> submitFeedback(FeedbackModel feedback) async {
    await _feedbackCollection.add(feedback.toMap());
  }

  // Extension Visit Operations
  Future<void> logExtensionVisit(ExtensionVisitModel visit) async {
    await _extensionVisitsCollection.add(visit.toMap());
  }

  // Get current user data
  Stream<UserModel?> getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      return _usersCollection.doc(user.uid).snapshots().map((doc) {
        if (doc.exists) {
          return UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
        }
        return null;
      });
    }
    return Stream.value(null);
  }
}