import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/controllers/user_choice_controller.dart';
import '../../routes/navs.dart';

final userController = Get.find<UserChoiceController>();

class MySearchController extends GetxController {

  final TextEditingController textEditingController = TextEditingController();
  var searchText = ''.obs; // Text currently in the TextField
  var suggestions = <String>[].obs; // List of suggested texts
  var selectedSuggestion = ''.obs; // Selected suggestion

  //List of items to search
  final List<String> availableItems = [
    "Logistics",
    "Paralegal",
    "Bail Bond",
    "Legal Assistance",
    "News",
    "Litigation Support",
  ];

  // Method to update suggestions as user types
  void updateSuggestions(String input) {
    searchText.value = input;
    if (input.isEmpty) {
      suggestions.clear();
    } else {
      suggestions.value = availableItems
          .where((item) => item.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
  }

  // Method to handle suggestion click
  void selectSuggestion(String suggestion) {
    searchText.value = suggestion;
    textEditingController.text = suggestion;
    suggestions.clear();
  }

  // Method to perform the search and navigate
  void performSearch() {
    // Map the selected text to the appropriate screen
    switch (searchText.value) {
      case "Paralegal":
        Get.toNamed(Nav.lawyerParalegalHome);
        break;
      case "Logistics":
        Get.toNamed(Nav.logisticsDeliveryInfo);
        break;
      case "Bail Bond":
        Get.toNamed(Nav.bondStepA);
        break;
      case "Legal Assistance":
        Get.toNamed(Nav.legalServiceHome);
        break;
      case "News":
        Get.toNamed(Nav.newsScreen);
        break;
      case "Litigation Support":
        Get.toNamed(Nav.findAlawyer);
        break;
      default:
        Get.snackbar("Error", "No matching functionality found");
        break;
    }
  }
}
