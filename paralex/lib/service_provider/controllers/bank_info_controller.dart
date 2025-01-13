import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../../routes/navs.dart';
import '../services/api_service.dart';
import 'user_choice_controller.dart'; // Import the UserChoiceController

class BankInfoController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> banks = [
    "Access Bank", "Citibank", "Diamond Bank", "Ecobank", "Fidelity Bank",
    "First Bank of Nigeria", "FCMB", "GTBank", "Heritage Bank", "Keystone Bank",
    "Polaris Bank", "Stanbic IBTC Bank", "Sterling Bank", "Union Bank",
    "United Bank for Africa (UBA)", "Unity Bank", "Wema Bank", "Zenith Bank",
  ];

  final bvnController = TextEditingController();
  final ninController = TextEditingController();
  final bankController = TextEditingController();
  final accountNumberController = TextEditingController();
  final bankCodeController = TextEditingController();
  final accNameController = TextEditingController();

  Rx<File?> passportImage = Rx<File?>(null);
  RxBool isLoading = false.obs;
  Rx<Position?> userLocation = Rx<Position?>(null);

  final ImagePicker _picker = ImagePicker();

  final UserChoiceController _userChoiceController = Get.find<UserChoiceController>();

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

  // Request Location Permissions
  Future<bool> _requestLocationPermission() async {
    while (true) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        continue; // Keep checking until service is enabled
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          Get.snackbar("Permission Error", "Please enable location permissions in settings.");
          await Geolocator.openAppSettings();
          continue; // Keep looping until permissions are granted
        } else if (permission == LocationPermission.denied) {
          continue; // Keep requesting until granted
        }
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        return true; // Exit the loop when permissions are granted
      }
    }
  }

  // Get User Location
  Future<void> fetchUserLocation() async {
    bool permissionGranted = await _requestLocationPermission();
    if (permissionGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );
        userLocation.value = position;
      } catch (e) {
        Get.snackbar("Location Error", "Failed to get location: $e");
      }
    }
  }


  void submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      if (passportImage.value == null) {
        Get.snackbar("Error", "Please upload a passport image.");
        return;
      }

      await fetchUserLocation();

      try {
        isLoading.value = true;
        ApiService apiService = ApiService();
        String uploadedPhotoUrl = await apiService.uploadImage1(passportImage.value!);

        Map<String, dynamic> userData = Get.arguments;

        userData.addAll({
          "bvn": bvnController.text,
          "nin": ninController.text,
          "bankName": bankController.text,
          "accountNumber": accountNumberController.text,
          "bankCode": bankCodeController.text,
          "accountName": accNameController.text,
          "passportUrl": uploadedPhotoUrl,
          "email": _userChoiceController.email.value, // Include email
          "location": {
            "x": userLocation.value!.longitude,
            "y":userLocation.value!.latitude
          },
        });
        print("User Data: $userData");
        var response = await apiService.postRequest(
          'service-provider/driver/profile/',
          userData,
        );

        Get.snackbar("Success", "Your profile has been successfully updated!");
        Get.offNamed(Nav.deliveryInfo1);
      } catch (e) {
        Get.snackbar("Error", "An error occurred: $e");
      } finally {
        isLoading.value = false;
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
