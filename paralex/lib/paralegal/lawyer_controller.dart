import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paralex/paralegal/lawyer_model.dart';

import '../routes/navs.dart';
import '../service_provider/services/api_service.dart';

class LawyerController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var lawyersList = <Lawyer>[].obs; // Store the fetched lawyers
  var errorMessage = ''.obs;
  var reviews = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
    fetchLawyers();
  }

  void fetchReviews() async {
    // Simulate fetching data from the backend
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    reviews.value = [
      {
        "name": "Johnbull Ekanem",
        //"text": "Johnbull's review text goes here.",
        "rating": "4.5",
        "imagePath": null
      },
      {
        "name": "Olusegun Obasanjo",
        "text": "Olusegun's review text goes here.",
        "rating": "4.8",
        "imagePath": null
      },
      {
        "name": "Elon Musk",
        "text": "Musk's review text goes here.",
        "rating": "4.5",
        "imagePath": null
      },
    ];
  }

  void fetchLawyers({int? pageSize = 1000}) async {
    try {
      final response = await _apiService.getRequest(
        'service-provider/lawyer/profile/?pageSize=$pageSize',
      );


      var res = response['data'] as List;
      debugPrint('Lawyer>>>===${res.first}');
      // debugPrint('Lawyer>>>${Lawyer.fromJson(res.first)}');

      lawyersList.assignAll(
        (response['data'] as List).map((item) => Lawyer.fromJson(item)).toList(),
      );
    } catch (e) {
      debugPrint('error>>>$e');
    }
  }

  void requestLitigationSupport(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.postRequest('litigation-support/', data);

      Get.snackbar(
        'Success',
        'LitigationSupport submitted successfully!',
        snackPosition: SnackPosition.TOP,
      );

      // Pass firstName and lastName to the next screen
      Get.toNamed(Nav.getLawyerSubmitted);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  Future<String> uploadFile(File file) async {
    var response = await _apiService.uploadImage(file);
    return response;
  }
}
