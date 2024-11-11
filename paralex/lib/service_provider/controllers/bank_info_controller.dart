import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes/navs.dart';

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

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      if (passportImage.value == null) {
        Get.snackbar("Error", "Please upload a passport image.");
      } else {
        Get.toNamed(Nav.notification);
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
    super.dispose();
  }
}
