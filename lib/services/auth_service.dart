import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Email & Password Sign Up
  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password, {
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
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user profile in Firestore
      if (userCredential.user != null) {
        UserModel user = UserModel(
          id: userCredential.user!.uid,
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

        await _databaseService.createUser(user);
      }

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Email & Password Sign In
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Google Sign In
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Need to check platform support
      if (!Platform.isAndroid && !Platform.isIOS) {
        throw PlatformException(
          code: 'UNSUPPORTED_PLATFORM',
          message: 'Google Sign In is not supported on this platform.'
        );
      }
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: ['email'],
      ).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if user is new
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        // Create user profile in Firestore
        if (userCredential.user != null) {
          UserModel user = UserModel(
            id: userCredential.user!.uid,
            fullName: userCredential.user!.displayName ?? 'New User',
            phone: userCredential.user!.phoneNumber ?? '',
            gender: 'Prefer not to say',
            age: 0,
            country: '',
            region: '',
            district: '',
            farmSize: 0.0,
            mainCrops: [],
            plantingSeason: '',
            preferredChannels: ['App'],
          );

          await _databaseService.createUser(user);
        }
      }

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  // Password Reset
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Update User Profile
  Future<void> updateUserProfile(UserModel user) async {
    await _databaseService.updateUser(user);
  }
}