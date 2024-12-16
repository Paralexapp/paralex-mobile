import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes/navs.dart';
import '../services/api_service.dart';

class BankInfoController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> banks = [
    "Access Bank",
    "Citibank",
    "Diamond Bank",
    "Ecobank",
    "Fidelity Bank",
    "First Bank of Nigeria",
    "FCMB",
    "GTBank",
    "Heritage Bank",
    "Keystone Bank",
    "Polaris Bank",
    "Stanbic IBTC Bank",
    "Sterling Bank",
    "Union Bank",
    "United Bank for Africa (UBA)",
    "Unity Bank",
    "Wema Bank",
    "Zenith Bank",
  ];

  final bvnController = TextEditingController();
  final ninController = TextEditingController();
  final bankController = TextEditingController();
  final accountNumberController = TextEditingController();
  final bankCodeController = TextEditingController();
  final accNameController = TextEditingController();

  Rx<File?> passportImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      final fileExtension = pickedFile.path.split('.').last.toLowerCase();
      if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
        passportImage.value = File(pickedFile.path);
      } else {
        Get.snackbar("Invalid File", "Please select a JPG or JPEG image.");
      }
    }
  }

  void removeImage() {
    passportImage.value = null;
  }


  void submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      if (passportImage.value == null) {
        Get.snackbar("Error", "Please upload a passport image.");
        return;
      }

      try {
        Get.snackbar("Uploading", "Uploading your passport image... Please wait.");
        ApiService apiService = ApiService();
        String uploadedPhotoUrl = await apiService.uploadImage1(passportImage.value!);

        //Retrieve `userData` passed from the previous screen
        Map<String, dynamic> userData = Get.arguments;

        //Add the current screen's inputs to `userData`
        userData.addAll({
          "bvn": bvnController.text,
          "nin": ninController.text,
          "bankName": bankController.text,
          "accountNumber": accountNumberController.text,
          "bankCode": bankCodeController.text,
          "accountName": accNameController.text,
          "passportUrl": uploadedPhotoUrl, // Add the uploaded image URL
        });

        //Submit `userData` to the backend
        Get.snackbar("Submitting", "Submitting your information... Please wait.");
        debugPrint("User Data: ${jsonEncode(userData)}");
        var response = await apiService.postRequest(
          'service-provider/driver/profile/',
          userData,
        );
        Get.snackbar("Success", "Your profile has been successfully updated!");
        Get.toNamed(Nav.deliveryInfo);
      } catch (e) {
        Get.snackbar("Error", "An error occurred: $e");
      }
    } else {
      Get.snackbar("Error", "Please fill all required fields.");
    }
  }


  @override
  void dispose() {
    bvnController.dispose();
    ninController.dispose();
    bankController.dispose();
    accountNumberController.dispose();
    accNameController.dispose();
    bankCodeController.dispose();
    super.dispose();
  }
}
