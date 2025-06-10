import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/controllers/signup_controller.dart';

import '../services/api_service.dart';
import 'auth_controller.dart';

final ApiService _apiService = ApiService();
final AuthController _authController = Get.put(AuthController());
// Define the UserType enum
enum UserType {
  USER,
  SERVICE_PROVIDER_LAWYER,
  SERVICE_PROVIDER_RIDER,
}

// Extension for converting UserType to string
extension UserTypeExtension on UserType {
  String get stringValue {
    switch (this) {
      case UserType.USER:
        return 'USER';
      case UserType.SERVICE_PROVIDER_LAWYER:
        return 'SERVICE_PROVIDER_LAWYER';
      case UserType.SERVICE_PROVIDER_RIDER:
        return 'SERVICE_PROVIDER_RIDER';
    }
  }
}

class UserChoiceController extends GetxController {

  // Store the initial UserType
  late UserType initialUserType;

  // Observable UserType, default to USER
  var selectedUserType = UserType.USER.obs;

  // User details
  var email = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;
  var photoUrl = ''.obs;
  var aboutMe = ''.obs;

  // Authentication details
  var userIdToken = ''.obs;
  var userEmail = ''.obs;
  var authToken = ''.obs;
  var resetToken = ''.obs;

  // Backward-compatible properties
  var isUser = true.obs; // Reflects if the user is a "USER"
  var isRider = true.obs; // Reflects if the user is a "SERVICE_PROVIDER_RIDER"
  var isLawyer = true.obs;

  // Getter for user type as string
  String get userType => selectedUserType.value.stringValue;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  void setInitialUserType(UserType userType) {
    initialUserType = userType;
    selectedUserType.value = userType;
  }

  void clearSession() {
    firstName.value = '';
    lastName.value = '';
    email.value = '';
    photoUrl.value = '';
    aboutMe.value = '';
    userIdToken.value = '';
    authToken.value = '';
    selectedUserType.value = initialUserType; // Reset to the initial user type

    // Optionally clear other session-related data if necessary
  }

  // Update logic for backward compatibility
  void _updateCompatibilityFlags() {
    isUser.value = selectedUserType.value == UserType.USER;
    isRider.value = selectedUserType.value == UserType.SERVICE_PROVIDER_RIDER;
    isLawyer.value = selectedUserType.value == UserType.SERVICE_PROVIDER_LAWYER;
  }

  // Methods to set user type
  void selectUser() {
    selectedUserType.value = UserType.USER;
    _updateCompatibilityFlags();
  }


  void selectServiceProviderLawyer() {
    selectedUserType.value = UserType.SERVICE_PROVIDER_LAWYER;
    _updateCompatibilityFlags();
  }


  void selectServiceProviderRider() {
    selectedUserType.value = UserType.SERVICE_PROVIDER_RIDER;
    _updateCompatibilityFlags();
  }

  Future<void> fetchLoggedInUser() async {
    if (authToken.value.isEmpty) {
      print('Error: Auth token is not set.');
      return;
    }

    final url =
        'https://paralex-be.onrender.com/api/v1/auth/get-user';
    try {
      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${authToken.value}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        firstName.value = data['firstName'] ?? '';
        lastName.value = data['lastName'] ?? '';
        email.value = data['email'] ?? '';
        phoneNumber.value = data['phoneNumber'] ?? '';  // Set phone number
        photoUrl.value = data['photoUrl'] ?? '';
        aboutMe.value = data['aboutMe'] ?? '';
        print('Fetched User Data: $data');


      } else {
        print('Failed to fetch logged-in user: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching logged-in user: $e');
    }
  }

  Future<Map<String, dynamic>> fetchUserByEmail(String email) async {
    try {
      // Construct the endpoint with the email parameter
      String endpoint = 'api/v1/auth/get-user-by-email/email?email=$email';

      Map<String, dynamic> response = await apiService.getRequest(endpoint);

      // Debugging: Print the response
      debugPrint("User Data: $response");

      // Return the response
      return response;
    } catch (e) {
      // Handle errors
      debugPrint("Error fetching user by email: $e");
      rethrow;
    }
  }

  Future<void> loginUser(email,password) async {
    final loginData = {
      'email':  email,
      'password': password,
    };

    try {
      // Step 1: Authenticate the user and retrieve the token
      final response = await _apiService.postRequest(
        'api/v1/auth/login', loginData,
      );

      final authToken = response['data'];
      _authController.token.value = authToken;
      _authController.userEmail.value = email.toString();

      this.authToken.value = authToken;
      print("authToken = $authToken");
    } catch (e) {
        Get.snackbar(
          'Error',
          'An unexpected error occurred: $e',
          snackPosition: SnackPosition.TOP,
        );

    }
  }

  Future<bool> updateBio(String newBio) async {
    try {
      isLoading.value = true;
      final result = await _apiService.updateUserBio(newBio);
      aboutMe.value = newBio;
      return true;
    } catch (e) {
      debugPrint('Bio update failed: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }




  Future<bool> deleteAccount(String email) async {
    try {
      isLoading(true);
      errorMessage('');

      // Call your API endpoint for account deletion
      final response = await _apiService.postRequest('admin/delete-user?userId=$userIdToken', {});

      if (response['data'] != null) {
        debugPrint('delete account response>>>>${response['data']}');
        return true;
      } else {
        errorMessage(response['error'] ?? 'Failed to delete account');
        return false;
      }
    } catch (e) {
      debugPrint('response>>>>$e');
      errorMessage('An error occurred while deleting account');
      return false;
    } finally {
      isLoading(false);
    }

  }

  Future<bool> updateProfilePhoto(File imageFile) async {
    try {
      // Step 1: Upload image and save URL to user entity
      String uploadedUrl = await _apiService.uploadProfilePic(imageFile);

      // Step 2: Update locally
      photoUrl.value = uploadedUrl;

      // Step 3: Success
      Get.snackbar('Success', 'Profile photo updated successfully');
      return true;
    } catch (e) {
      // Handle error
      Get.snackbar('Error', e.toString());
      return false;
    }
  }


  @override
  void onInit() {
    super.onInit();
    _updateCompatibilityFlags(); // Ensure compatibility flags are set correctly
    fetchLoggedInUser(); // Optionally fetch the logged-in user
  }
}
