import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:paralex/paralegal/lawyer_dashboard.dart';
import '../../routes/navs.dart';
import '../services/api_service.dart';

class AboutYouController extends GetxController {
  // Form controllers
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final stateController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  // Observable state variables
  var phoneNumber = "".obs;
  var isPhoneNumberValid = false.obs;
  var isCheckboxSelected = false.obs;
  var isButtonEnabled = false.obs;
  var selectedOption = "".obs;
  var stateChoice = "".obs;
  var isLoading = false.obs;
  DateTime? selectedDate;
  Rx<File?> passportImage = Rx<File?>(null);

  // Form validation key
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Listen for form field changes
    firstName.addListener(checkFormCompletion);
    lastName.addListener(checkFormCompletion);
    address.addListener(checkFormCompletion);
    dateController.addListener(checkFormCompletion);
    stateController.addListener(checkFormCompletion);
  }

  @override
  void onClose() {
    // Remove listeners to prevent memory leaks
    firstName.removeListener(checkFormCompletion);
    lastName.removeListener(checkFormCompletion);
    stateController.removeListener(checkFormCompletion);
    address.removeListener(checkFormCompletion);
    dateController.removeListener(checkFormCompletion);
    // Dispose controllers
    firstName.dispose();
    lastName.dispose();
    address.dispose();
    dateController.dispose();
    stateController.dispose();
    super.onClose();
  }

  void checkFormCompletion() {
    // Enable button only if all conditions are met
    isButtonEnabled.value = firstName.text.isNotEmpty && lastName.text.isNotEmpty && stateController.text.isNotEmpty &&
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

  void onContinueButtonPressed() async {
    if (isLoading.value) return; // Prevent multiple presses

    bool isPhoneValid = _validatePhoneNumber(phoneNumber.value);
    isPhoneNumberValid.value = isPhoneValid;

    if (validateForm()) {
      if (isPhoneValid) {
        if (isCheckboxSelected.value) {
          if (passportImage.value == null) {
            Get.snackbar("Error", "Please upload a passport image.");
          } else {
            try {
              isLoading.value = true;
              ApiService apiService = ApiService();
              String photoUrl = await apiService.uploadImage1(passportImage.value!);
              Map<String, dynamic> userData = {
                "email": userController.email.value,
                "firstName": firstName.text,
                "lastName": lastName.text,
                //"address": address.text,
                //"dateOfBirth": dateController.text,
                "stateOfResidence": stateController.text,
                "phoneNumber": phoneNumber.value,
                "photoUrl": photoUrl,
                "hasRiderCard": selectedOption.value =='Yes',
              };
              debugPrint("User Data: ${jsonEncode(userData)}");
              Get.toNamed(Nav.aboutServiceProviderPage2, arguments: userData);
            } catch (e) {
              Get.snackbar("Error", "An error occurred: $e");
            } finally {
              isLoading.value = false;
            }
          }
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
        width: 300,
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

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      final fileExtension = pickedFile.path.split('.').last.toLowerCase();
      if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
        passportImage.value = File(pickedFile.path);
      } else {
        Get.snackbar("Invalid File", "Please select a JPG or JPEG image.");
      }
    }
  }

  void removeImage() {
    passportImage.value = null;
  }
}
