import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/service_provider/services/firebase_service.dart';

class SignupController extends GetxController {
  var emailText = "".obs;
  var passwordText = "".obs;
  var confirmPasswordText = "".obs;

  var isEmailValid = false.obs;
  var isMinLengthValid = false.obs;
  var isUpperCaseValid = false.obs;
  var isSpecialCharacterValid = false.obs;
  var loading = false.obs;

  var passwordVisibility = true.obs;
  var confirmPasswordVisibility = true.obs;

  final passwordController = TextEditingController();
  FirebaseService auth = FirebaseService();
  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool hasMinLength(String password) => password.length >= 8;
  bool hasUpperCase(String password) => password.contains(RegExp(r'[A-Z]'));
  bool hasSpecialCharacter(String password) => password.contains(RegExp(r'[!@#\$%\^&\*\?]'));

  void validatePassword(String password) {
    isMinLengthValid.value = hasMinLength(password);
    isUpperCaseValid.value = hasUpperCase(password);
    isSpecialCharacterValid.value = hasSpecialCharacter(password);
  }

  void validateEmailField(String email) {
    isEmailValid.value = validateEmail(email);
  }

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisibility.value = !confirmPasswordVisibility.value;
  }

  Future<void> signUp() async{
    try{
      loading.value = true;
      var userIdToken = await auth.signup(email: emailText.value, password: passwordText.value);
      log('$userIdToken');
      loading.value = false;
      Get.toNamed(Nav.otpScreen);
    }
    catch(e){
      log('sign up failed');
      loading.value = false;
    }
}
  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
