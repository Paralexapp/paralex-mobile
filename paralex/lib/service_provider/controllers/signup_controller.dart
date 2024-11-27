import 'dart:developer';
import 'package:paralex/service_provider/controllers/user_choice_controller.dart';
import 'package:paralex/service_provider/services/api_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:paralex/routes/navs.dart';
//import 'package:paralex/service_provider/services/firebase_service.dart';

final ApiService apiService = ApiService();
final userChoiceController = Get.find<UserChoiceController>();

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
  //FirebaseService auth = FirebaseService();
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

  Future<void> signUp() async {
    try {
      loading.value = true;
      final response = await apiService.postRequest('register', {
        'password': passwordText.value,
        'confirmPassword':confirmPasswordText.value,
        'userType':userChoiceController.userType,
        'email': emailText.value,
      });

      log('Signup successful: ${response['user_id']}');
      Get.toNamed(Nav.otpScreen);
    } catch (e) {
      log('Error during signup: $e');
      if (e is Exception) {
        String errorMessage = e.toString();
        if (errorMessage.contains("Customer Already Exist")) {
          Get.snackbar(
            'Error',
            '$e.',
            snackPosition: SnackPosition.TOP,
          );
          Get.toNamed(Nav.login);
        }
      }
    } finally {
      loading.value = false;
    }
  }
  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
