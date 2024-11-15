import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paralax/service_provider/services/exception_handler.dart';

class FirebaseService {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  final FirebaseFirestore _fsInstance = FirebaseFirestore.instance;

  Future<String?> signup({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('user account successfully created');
      return response.user?.uid;
    } catch (e) {
      log('$e');
      log('account creation failed');
      await ExceptionHandler.handleException(e);
      return null;
    }
  }

  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('sign in was successful');
      return response.user?.uid;
    } catch (e) {
      log('$e');
      log('sign in failed');
      await ExceptionHandler.handleException(e);
      return null;
    }
  }

}