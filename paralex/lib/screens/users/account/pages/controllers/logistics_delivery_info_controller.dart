import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/screens/users/account/home.dart';
import 'package:paralex/service_provider/models/driver_model.dart';
import 'package:paralex/service_provider/services/api_service.dart';
import 'package:http/http.dart' as http;

import '../../../../../routes/navs.dart';
import '../../../../../service_provider/controllers/auth_controller.dart';
import '../../../../../service_provider/controllers/user_choice_controller.dart';
import '../../../../../service_provider/models/place_model.dart';
import '../Logistics/logistics_find_delivery.dart';
import '../Logistics/webview_payment_screen.dart';

class LogisticsDeliveryInfoController extends GetxController {
  final AuthController _authController = Get.find();
  final UserChoiceController userController = Get.find();

  final ApiService _apiService = ApiService();

  DeliveryResponse? delivery;
  DeliveryResponse? delivery2;
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

  Future<List<DriverModel>?> requestDelivery() async {
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

      final response = await _apiService.postRequest('delivery/request/', data);

      delivery = DeliveryResponse.fromJson(response);
      delivery2 = DeliveryResponse.fromJson({
        "id": "677e6f0124bf9f2b5a81f140",
        "trackingId": "OCOkA0A",
        "deliveryStage": null,
        "nearbyDrivers": [
          {
            "id": '1',
            "name": 'John Doe',
            "phoneNumber": '123-456-7890',
            "riderPhotoUrl": 'https://via.placeholder.com/150',
            "distance": '2.5 km',
          },
          {
            "id": '2',
            "name": 'Jane Smith',
            "phoneNumber": '987-654-3210',
            "riderPhotoUrl": 'https://via.placeholder.com/150',
            "distance": '3.1 km',
          },
        ]
      });
      Get.snackbar(
        'Success',
        'Delivery  Requested successfully!',
        snackPosition: SnackPosition.TOP,
      );

      return delivery?.nearbyDrivers;

      // // Pass firstName and lastName to the next screen
      // Get.toNamed(Nav.logisticsPaymentMethod);
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

  void assignDriver(DriverModel driver) async {
    debugPrint(
        'error===={"driverProfileId": ${driver.id}, "deliveryRequestId": ${delivery?.id}');
    final assignDriver = await _apiService.postRequest('delivery/request/assign',
        {"driverProfileId": driver.id, "deliveryRequestId": delivery?.id});
    Get.snackbar(
      'Successful',
      "Assign Driver Successful",
      snackPosition: SnackPosition.TOP,
    );
    Get.offAllNamed(Nav.home);
  }

  // Future<Map<String, dynamic>?> getDeliveryAmount() async {
  //   var data = {
  //     "driverProfileId": userController.email.value,
  //     "pickup": {
  //       "customerName":
  //           "${userController.lastName.value} ${userController.firstName.value}",
  //       "phoneNumber": senderPhoneNumberController.value,
  //       "address": senderStreetController.value,
  //       "latitude": senderLatitude.value,
  //       "longitude": senderLongitude.value,
  //       "description": orderDetailsController.value
  //     },
  //     "destination": {
  //       "recipientName": receiverNameController.value,
  //       "phoneNumber": receiverPhoneNumberController.value,
  //       "address": receiverStreetController.value,
  //       "latitude": recipientLatitude.value,
  //       "longitude": recipientLongitude.value,
  //       "categoryId": "na",
  //       "description": whatToDeliverController.value
  //     }
  //   };
  //
  //   try {
  //     isLoading.value = true;
  //
  //     final Map<String, dynamic> deliveryInformation =
  //         await _apiService.postRequest('delivery/request/information', data);
  //     Get.to(
  //       () => LogisticsFindDelivery(
  //         toDestination: senderStreetController.value,
  //         fromLocation: receiverStreetController.value,
  //         orderDetails: orderDetailsController.value,
  //         fare: deliveryInformation['amount'].toString(),
  //         distance: deliveryInformation['distance'].toString(),
  //       ),
  //     );
  //     isLoading.value = false;
  //     return deliveryInformation;
  //   } catch (e) {
  //     isLoading.value = false;
  //     debugPrint('error====$e');
  //     Get.snackbar(
  //       'Error',
  //       e.toString(),
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     return null;
  //   }
  // }

  Future<Map<String, dynamic>?> getDeliveryAmount() async {
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

      final Map<String, dynamic> deliveryInformation =
      await _apiService.postRequest('delivery/request/information', data);

      // Validate and parse 'amount' (int from backend)
      if (!deliveryInformation.containsKey('amount') ||
          deliveryInformation['amount'] == null) {
        throw Exception("Amount is missing or invalid in the API response");
      }
      int amount = deliveryInformation['amount'];

      // Validate and parse 'distance' (long from backend, treat as int in Dart)
      if (!deliveryInformation.containsKey('distance') ||
          deliveryInformation['distance'] == null) {
        throw Exception("Distance is missing or invalid in the API response");
      }
      int distance = deliveryInformation['distance'];

      // Navigate with numeric fare (int) and distance (int)
      Get.to(
            () => LogisticsFindDelivery(
          toDestination: senderStreetController.value,
          fromLocation: receiverStreetController.value,
          orderDetails: orderDetailsController.value,
          fare: amount, // Pass as int
          distance: distance, // Pass as int
        ),
      );

      isLoading.value = false;
      return deliveryInformation;
    } catch (e) {
      isLoading.value = false;
      debugPrint('error====$e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
      return null;
    }
  }


  void initializePayment(String amount) async {
    try {
      isLoading.value = true;
      final initResponse =
          await _apiService.postRequest('payment/bill/initialize-payment', {
        "email": _authController.userEmail.value,
        "amount": amount,
      });

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
    try {
      isLoading.value = true;

      final verifyResponse = await _apiService.postRequest(
          'payment/bill/verify-transaction?reference=$reference',
          {"reference": reference});
      //
      // debugPrint("request data====$data");
      // final response = await _apiService.postRequest('delivery/request/', data);
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

  Future<void> addLocation(PlaceModel place) async {
    List<Map<String, dynamic>> data = [
      {
        "name": place.displayName,
        "status": true,
        "latitude": place.latitude,
        "longitude": place.longitude
      }
    ];
    final url = Uri.parse('https://paralex-app-fddb148a81ad.herokuapp.com/locations/');
    debugPrint('url==$url');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authController.token.value}'
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Location add successful',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      String errorMessage = e.toString();
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.TOP,
      );
      throw Exception(errorMessage);
    }
  }
}
