import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectServiceController extends GetxController {
  var selectedButtonIndex = (-1).obs;

  void selectButton(int index) {
    selectedButtonIndex.value = index;
  }

  Color getButtonColor(int index) {
    return selectedButtonIndex.value == index ? const Color(0xFFFFEAF5) : Colors.white;
  }
}
