import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/service_provider/services/api_service.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:paralex/routes/navs.dart';

import '../../../service_provider/controllers/user_choice_controller.dart';

final userController = Get.find<UserChoiceController>();

class MoreAboutYou extends StatefulWidget {
  const MoreAboutYou({super.key});

  @override
  State<MoreAboutYou> createState() => _MoreAboutYouState();
}

class _MoreAboutYouState extends State<MoreAboutYou> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final ApiService _apiService = ApiService();
  String _phoneNumber = ''; // Store phone number
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    userController.firstName.value = _firstName.text;
    userController.lastName.value = _lastName.text;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tell us more about you",
              style: FontStyles.headingText
                  .copyWith(color: PaintColors.paralexpurple, fontSize: 22),
            ),
            Text("Please use your name as it \nappears on your ID",
                style: FontStyles.smallCapsIntro.copyWith(
                    letterSpacing: 0,
                    color: PaintColors.generalTextsm,
                    fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _firstName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a value";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'Legal first name',
                          labelText: 'First name *',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: PaintColors.paralexpurple))),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _lastName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a value";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'Legal last name',
                          labelText: 'Last name *',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: PaintColors.paralexpurple))),
                    ),
                    const SizedBox(height: 20),
                    IntlPhoneField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'NG',
                      onChanged: (phone) {
                        _phoneNumber = phone.completeNumber;
                      },
                    ),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true, // Make it readonly
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        final DateTime? picked =
                        await DatePicker.showSimpleDatePicker(
                          context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                          dateFormat: "dd-MMMM-yyyy",
                          locale: DateTimePickerLocale.en_us,
                          looping: true,
                        );
                        if (picked != null) {
                          setState(() {
                            _selectedDate = picked;
                            _dateController.text =
                                DateFormat("dd-MMM-yyyy").format(picked);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: _isLoading ? null : updateUserProfile,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: size.width * 0.85,
                        decoration: const BoxDecoration(
                            color: PaintColors.paralexpurple,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            "CONTINUE",
                            style: FontStyles.smallCapsIntro.copyWith(
                                color: Colors.white,
                                letterSpacing: 0,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<void> updateUserProfile() async {
    if (_firstName.text.isEmpty ||
        _lastName.text.isEmpty ||
        _phoneNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Please complete all fields.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _apiService.putRequest('update-user-profile', {
        'email': userController.email.value,
        'phoneNumber': _phoneNumber,
        'firstName': _firstName.text,
        'lastName': _lastName.text,
      });

      final firstName = response['firstName'];
      final lastName = response['lastName'];

      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        snackPosition: SnackPosition.TOP,
      );

      // Pass firstName and lastName to the next screen
      Get.toNamed(Nav.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

}