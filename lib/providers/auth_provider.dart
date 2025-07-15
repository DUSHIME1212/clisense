import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  // Getters
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  // Initialize auth state
  void initialize() {
    _authService.authStateChanges.listen((User? firebaseUser) async {
      if (firebaseUser != null) {
        // User is signed in
        _user = await _authService.getUser(firebaseUser.uid);
        notifyListeners();
      } else {
        // User is signed out
        _user = null;
        notifyListeners();
      }
    });
  }

  // Sign up with email and password
  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String gender,
    required int age,
    required String country,
    required String region,
    required String district,
    required double farmSize,
    required List<String> mainCrops,
    required String plantingSeason,
    required List<String> preferredChannels,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signUpWithEmailAndPassword(
        email,
        password,
        fullName: fullName,
        phone: phone,
        gender: gender,
        age: age,
        country: country,
        region: region,
        district: district,
        farmSize: farmSize,
        mainCrops: mainCrops,
        plantingSeason: plantingSeason,
        preferredChannels: preferredChannels,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign in with email and password
  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signInWithEmailAndPassword(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signInWithGoogle();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.sendPasswordResetEmail(email);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Update user profile
  Future<void> updateProfile(UserModel updatedUser) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.updateUserProfile(updatedUser);
      _user = updatedUser;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
