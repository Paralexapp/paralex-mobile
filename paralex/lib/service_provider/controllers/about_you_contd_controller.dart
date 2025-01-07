import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutYouContdController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var bikeNumber = TextEditingController();
  var bikeType = TextEditingController();
  var bikeCapacity = TextEditingController();
  var chasisNumber = TextEditingController();
  var hasBike = true.obs; // Observable for the checkbox option

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      Get.snackbar(
        "Incomplete",
        "Please fill out all required fields",
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
}
