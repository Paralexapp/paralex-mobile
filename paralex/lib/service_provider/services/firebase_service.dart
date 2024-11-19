import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/service_provider/controllers/user_choice_controller.dart';
import 'package:paralax/service_provider/repo/local/local_storage.dart';
import 'package:paralax/service_provider/services/exception_handler.dart';
import 'package:paralax/service_provider/services/hive_service.dart';
import 'package:paralax/service_provider/services/http_service.dart';

class FirebaseService {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  final FirebaseFirestore _fsInstance = FirebaseFirestore.instance;
  final UserChoiceController controller = Get.put(UserChoiceController());
  final HiveService _hiveService = HiveService();
  final HttpService api = HttpService();

  Future<String?> signup({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('user account successfully created in firebase');
      String? idToken = await response.user?.getIdToken();
      log('Token retrieved successfully');
      controller.userIdToken.value = idToken.toString();
      // var localStorage = LocalStorage(idToken: idToken, email: email);
      // _hiveService.updateLocalStorage(localStorage);
      // log('token saved in local storage');
      // await sendEmailVerification();
      Map<String, dynamic> requestBodyEmailVerification ={
        "idToken": controller.userIdToken.value
      };
      log('Done with firebase, use endpoint to send email link verification');
      var result = await api.postData(HttpService.sendEmailVerification, controller.userIdToken.value, requestBodyEmailVerification);
      // return response.user?.uid;
      log('$result');
      if(result != null){
        log('Email link verification successfully sent to user');
        Get.snackbar('Success', 'Email verification link sent, check your email!');
      }
      else{
        log('Email link verification not sent to user');
        Get.snackbar('Failure', 'Email verification link not sent.');
      }
      return idToken;
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
      String? idToken = await response.user?.getIdToken();
      log('$idToken');
      log('Token retrieved successfully');
      // controller.userIdToken.value = idToken.toString();
      // var localStorage = LocalStorage(idToken: idToken, email: email);
      // _hiveService.updateLocalStorage(localStorage);
      // log('token saved in local storage');
      // return response.user?.uid;
      return idToken;
    } catch (e) {
      log('$e');
      log('sign in failed');
      await ExceptionHandler.handleException(e);
      return null;
    }
  }

  Future<void> sendEmailVerification() async {
    User? user = _authInstance.currentUser;

    if (user != null && !user.emailVerified) {
      try{
        await user.sendEmailVerification();
        log('Verification email sent to ${user.email}');
      }
      catch(e){
        log('$e');
        log('failed to send verification mail');
      }
    } else {
      log('User is already verified or not logged in.');
    }
  }

  Future<void> checkEmailVerified() async {
    User? user = _authInstance.currentUser;
    if (user != null) {
      try{
        await user.reload();
        if (user.emailVerified) {
          log('Email is verified!');
          Get.snackbar('Success', 'Email is verified.');
          // Get.toNamed(Nav.verificationScreen);
        } else {
          log('Email is not verified yet.');
          Get.snackbar('Failure', 'Email is not verified.');
        }
      }
      catch(e){
        log('$e');
        log('failed to send verification mail');
      }
    }
    else{
      log('User is null');
    }
  }

Future saveUserData({required String username, required String email, required String phoneNumber}) async{
    try{
      String userId =  _authInstance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'username': username,
        'email': email,
        'phoneNumber': phoneNumber,
        'createdAt': DateTime.now().toString(),
      });
    }
    catch(e){
      log('$e');
      log('failed to save user data in firestore');
    }
}

}