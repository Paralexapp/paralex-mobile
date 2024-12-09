import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/services/api_service.dart';
import 'package:http/http.dart' as http;

import '../../../../../routes/navs.dart';
import '../../../../../service_provider/models/place_model.dart';

class LogisticsDeliveryInfoController extends GetxController {
  final ApiService _apiService = ApiService();
  //For order details
  final senderStreetController = TextEditingController();
  final senderEntransController = TextEditingController();
  final senderEntryphoneController = TextEditingController();
  final senderPhoneNumberController = TextEditingController();
  final receiverStreetController = TextEditingController();
  final receiverEntransController = TextEditingController();
  final receiverEntryphoneController = TextEditingController();
  final receiverPhoneNumberController = TextEditingController();
  final receiverNameController = TextEditingController();
  final whatToDeliverController = TextEditingController();

  var isLoading = false.obs;

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

  void initializePayment(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final response =
          await _apiService.postRequest('payment/bill/initialize-payment/', data);

      Get.snackbar(
        'Success',
        'Payment Initialized successfully!',
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

  // Future<PredictionModel?> placeAutoComplete({required String placeInput}) async {
  //   try {
  //     Map<String, dynamic> querys = {'input': placeInput, 'key': APIKey.googleApiKey};
  //     final url =
  //         Uri.https("maps.googleapis.com", "/maps/api/place/autocomplete/json", querys);
  //     final response = await http.get(url);
  //     print('response.body====${response.body}');
  //     if (response.statusCode == 200) {
  //       return PredictionModel.fromJson(jsonDecode(response.body));
  //     } else {
  //       print('response.body====${response.body}');
  //       response.body;
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //   }
  //   return null;
  // }

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
