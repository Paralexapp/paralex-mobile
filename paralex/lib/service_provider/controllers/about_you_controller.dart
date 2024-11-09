// about_you_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../routes/navs.dart';

class AboutYouController extends GetxController {
  // Form controllers
  final TextEditingController legalName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Observable state variables
  var phoneNumber = "".obs;
  var isPhoneNumberValid = false.obs;
  var isCheckboxSelected = false.obs;
  var isButtonEnabled = false.obs;
  var selectedOption = "".obs;
  DateTime? selectedDate;

  // Form validation key
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Listen for form field changes
    legalName.addListener(checkFormCompletion);
    address.addListener(checkFormCompletion);
    dateController.addListener(checkFormCompletion);
  }

  @override
  void onClose() {
    // Remove listeners to prevent memory leaks
    legalName.removeListener(checkFormCompletion);
    address.removeListener(checkFormCompletion);
    dateController.removeListener(checkFormCompletion);
    // Dispose controllers
    legalName.dispose();
    address.dispose();
    dateController.dispose();
    super.onClose();
  }

  void checkFormCompletion() {
    // Enable button only if all conditions are met
    isButtonEnabled.value = legalName.text.isNotEmpty &&
        address.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        isPhoneNumberValid.value &&
        isCheckboxSelected.value;
  }

  void onPhoneNumberChanged(PhoneNumber phone) {
    phoneNumber.value = phone.completeNumber;
    isPhoneNumberValid.value =
        _validatePhoneNumber(phone.completeNumber); // Improved validation
    checkFormCompletion();
  }

  bool _validatePhoneNumber(String number) {
    return number.isNotEmpty && number.length >= 10; // Example validation
  }

  Future<void> onDateOfBirthTap(BuildContext context) async {
    final DateTime? picked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    if (picked != null) {
      selectedDate = picked;
      dateController.text = DateFormat("dd-MMM-yyyy").format(picked);
    }
  }

  void onCheckboxChanged(bool value) {
    isCheckboxSelected.value = value;
    checkFormCompletion();
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false; // Null-safe validation
  }

  void updateSelectedOption(String option) {
    selectedOption.value = option;
    isCheckboxSelected.value = true; // Also mark the checkbox as selected
    checkFormCompletion();
  }

  void onContinueButtonPressed() {
    bool isPhoneValid = _validatePhoneNumber(phoneNumber.value);
    isPhoneNumberValid.value = isPhoneValid;
    if (validateForm()) {
      if (isPhoneValid) {
        if (isCheckboxSelected.value) {
          Get.toNamed(Nav.aboutServiceProviderPage2);
        } else {
          Get.snackbar(
            "Incomplete",
            "Please select a checkbox option",
            snackPosition: SnackPosition.TOP,
          );
        }
      } else {
        Get.snackbar(
          "Incomplete",
          "Please fill out the phone number field",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Incomplete",
        "Please fill out all required fields",
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
