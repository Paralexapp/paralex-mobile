import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/navs.dart';

class GuarantorDetailController extends GetxController {
  // Define controllers for each form field
  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> userData = Get.arguments;

  final guarantorController = TextEditingController();
  final stateController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  // Define reactive variables for selected values and validation states
  var selectedOption = ''.obs;
  var stateChoice = ''.obs;
  var phoneNumber = ''.obs;

  // Email validation regex
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // Function to validate email format
  bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  void validateAndSubmit() {
    if (formKey.currentState!.validate() && phoneNumber.value.isNotEmpty) {
      Map<String, dynamic> guarantorData = {
        "guarantorClass": guarantorController.text,
        "guarantorPhoneNumber": phoneNumber.value,
        "guarantorEmail": emailController.text,
        "guarantorStateOfResidence": stateController.text,
        "guarantorResidentialAddress": addressController.text,
      };
      userData.addAll(guarantorData);
      Get.toNamed(Nav.bankInfo, arguments: userData);
    } else {
      if (phoneNumber.value.isEmpty) {
        Get.snackbar("Error", "Please enter a valid phone number.");
      } else {
        Get.snackbar("Error", "Please fill all required fields.");
      }
    }
  }

  // Helper function to select guarantor
  Future<void> showGuarantorDialog() async {
    await Get.defaultDialog<String>(
      title: "Choose an Option",
      content: Obx(() => Column(
        children: [
          RadioListTile<String>(
            title: Text("Parent"),
            value: "Parent",
            groupValue: selectedOption.value,
            onChanged: (value) {
              selectedOption.value = value!;
              guarantorController.text = selectedOption.value;
              Get.back(); // Close the dialog immediately
            },
          ),
          RadioListTile<String>(
            title: Text("Friend"),
            value: "Friend",
            groupValue: selectedOption.value,
            onChanged: (value) {
              selectedOption.value = value!;
              guarantorController.text = selectedOption.value;
              Get.back();
            },
          ),
          RadioListTile<String>(
            title: Text("Sibling"),
            value: "Sibling",
            groupValue: selectedOption.value,
            onChanged: (value) {
              selectedOption.value = value!;
              guarantorController.text = selectedOption.value;
              Get.back();
            },
          ),
        ],
      )),
    );
  }


  // Helper function to select state
  Future<void> showNgStatesDialog() async {
    List<String> nigeriaStates = [
      'Abia', 'Adamawa', 'Akwa Ibom', 'Anambra', 'Bauchi', 'Bayelsa', 'Benue', 'Borno', 'Cross River',
      'Delta', 'Ebonyi', 'Edo', 'Ekiti', 'Enugu', 'Gombe', 'Imo', 'Jigawa', 'Kaduna', 'Kano',
      'Katsina', 'Kebbi', 'Kogi', 'Kwara', 'Lagos', 'Nasarawa', 'Niger', 'Ogun', 'Ondo',
      'Osun', 'Oyo', 'Plateau', 'Rivers', 'Sokoto', 'Taraba', 'Yobe', 'Zamfara', 'Federal Capital Territory'
    ];
    nigeriaStates.sort();

    String? selectedState = await Get.defaultDialog<String>(
      title: "Choose a State in Nigeria",
      content: SizedBox(
        height: 300,
        child: Obx(() => ListView(
          children: nigeriaStates.map((state) {
            return RadioListTile<String>(
              title: Text(state),
              value: state,
              groupValue: stateChoice.value,
              onChanged: (value) {
                stateChoice.value = value!;
                stateController.text = stateChoice.value;
                Get.back();
              }
            );
          }).toList(),
        ),
      ),
      ),
    );
  }
}
