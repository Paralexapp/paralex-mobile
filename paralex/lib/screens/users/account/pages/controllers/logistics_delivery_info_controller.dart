import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/services/api_service.dart';
import 'package:http/http.dart' as http;

import '../../../../../routes/navs.dart';
import '../../../../../service_provider/controllers/auth_controller.dart';
import '../../../../../service_provider/controllers/user_choice_controller.dart';
import '../../../../../service_provider/models/place_model.dart';
import '../Logistics/webview_payment_screen.dart';

class LogisticsDeliveryInfoController extends GetxController {
  final AuthController _authController = Get.find();
  final UserChoiceController userController = Get.find();

  final ApiService _apiService = ApiService();
  //For order details
  var senderStreetController = ''.obs;
  var senderEntransController = ''.obs;
  var senderEntryphoneController = ''.obs;
  var senderPhoneNumberController = ''.obs;
  var receiverStreetController = ''.obs;
  var receiverEntransController = ''.obs;
  var receiverEntryphoneController = ''.obs;
  var receiverPhoneNumberController = ''.obs;
  var receiverNameController = ''.obs;
  var whatToDeliverController = ''.obs;
  var orderDetailsController = ''.obs;
  var fareController = ''.obs;

  var senderLatitude = 0.0.obs;
  var senderLongitude = 0.0.obs;
  var recipientLatitude = 0.0.obs;
  var recipientLongitude = 0.0.obs;

  var isLoading = false.obs;
  Map<String, dynamic> deliveryData = <String, dynamic>{}.obs;

  void submitCourierDelivery() {}

  void requestDelivery(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;

      final response = await _apiService.postRequest('delivery/request/', data);

      Get.snackbar(
        'Success',
        'Delivery  Requested successfully!',
        snackPosition: SnackPosition.TOP,
      );

      // Pass firstName and lastName to the next screen
      Get.toNamed(Nav.logisticsPaymentMethod);
    } catch (e) {
      debugPrint('error====$e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void initializePayment() async {
    try {
      isLoading.value = true;
      final initResponse =
          await _apiService.postRequest('payment/bill/initialize-payment', {
        "email": _authController.userEmail.value,
        "amount": 1000,
      });

      debugPrint('initResponse====${initResponse['data']}');
      final Map<String, dynamic> authUrl = initResponse['data'];

      // Navigate to the WebViewPaymentScreen
      Get.to(
        () => WebViewPaymentScreen(paymentData: authUrl),
      );
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint('error====$e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void verifyPayment(String reference) async {
    var data = {
      "driverProfileId": userController.email.value,
      "pickup": {
        "customerName":
            "${userController.lastName.value} ${userController.firstName.value}",
        "phoneNumber": senderPhoneNumberController.value,
        "address": senderStreetController.value,
        "latitude": senderLatitude.value,
        "longitude": senderLongitude.value,
        "description": orderDetailsController.value
      },
      "destination": {
        "recipientName": receiverNameController.value,
        "phoneNumber": receiverPhoneNumberController.value,
        "address": receiverStreetController.value,
        "latitude": recipientLatitude.value,
        "longitude": recipientLongitude.value,
        "categoryId": "na",
        "description": whatToDeliverController.value
      }
    };
    try {
      isLoading.value = true;

      final verifyResponse = await _apiService.postRequest(
          'payment/bill/verify-transaction?reference=$reference',
          {"reference": reference});
      //
      debugPrint("request data====$data");
      final response = await _apiService.postRequest('delivery/request/', data);
      isLoading.value = false;
      Get.toNamed(Nav.logisticsPaymentMethod3);
    } catch (e) {
      isLoading.value = false;
      debugPrint('error====$e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<List<PlaceModel>> searchPlace(String query) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List results = json.decode(response.body);
      return results.map((place) => PlaceModel.fromJson(place)).toList();
    } else {
      throw Exception('Failed to fetch places');
    }
  }
}
