// about_you.dart
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../reusables/back_button.dart';
import '../../../reusables/fonts.dart';
import '../../../reusables/paints.dart';
import '../../../routes/navs.dart';
import '../../controllers/about_you_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class AboutYou extends StatelessWidget {
  AboutYou({super.key});

  final AboutYouController controller = Get.put(AboutYouController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: PinkButton.backButton,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tell us more about you",
                  style: FontStyles.headingText.copyWith(
                    color: PaintColors.paralaxpurple,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "Please use your name as it \nappears on your ID",
                  style: FontStyles.smallCapsIntro.copyWith(
                    letterSpacing: 0,
                    color: PaintColors.generalTextsm,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: controller.legalName,
                      hintText: 'Legal last name',
                      labelText: 'Legal last name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your legal name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.address,
                      hintText: 'Residential address',
                      labelText: 'Residential address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your residential address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                     IntlPhoneField(
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Color(0xFFECF1F4),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                      ),
                      initialCountryCode: 'NG',
                      onChanged: controller.onPhoneNumberChanged,
                    ),
                    CustomTextFormField(
                      ontap: () => controller.onDateOfBirthTap(context),
                      controller: controller.dateController,
                      readonly: true,
                      labelText: 'Date Of birth',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select your date of birth";
                        }
                        return null;
                      },
                      suffixIcon: const Icon(Icons.calendar_today),
                      //onSuffixTap: () => controller.onDateOfBirthTap(context),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Do you have a rider card?",
                      style: FontStyles.smallCapsIntro.copyWith(
                          letterSpacing: 0,
                          color: Color(0xFF868686),
                          fontSize: 15),
                    ),
                    CheckboxOptions(
                      controller: controller,
                      onOptionSelected: controller.onCheckboxChanged,
                    ),
                    SizedBox(height: size.height * 0.12),
                    CustomButton(
                          desiredWidth: 0.85,
                          buttonText: "CONTINUE",
                          buttonColor: PaintColors.paralaxpurple,
                          ontap: controller.onContinueButtonPressed
                          ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "By clicking continue you agree to our ",
                                style: FontStyles.smallCapsIntro.copyWith(
                                    letterSpacing: 0,
                                    color: PaintColors.generalTextsm,
                                    fontSize: 14),
                              ),
                              Text(
                                "Terms of ",
                                style: FontStyles.smallCapsIntro.copyWith(
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    color: PaintColors.paralaxpurple,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Service"),
                              SizedBox(
                                width: 5,
                              ),
                              Text("and"),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Privacy policy "),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckboxOptions extends StatelessWidget {
  final Function(bool) onOptionSelected;
  final AboutYouController controller;

  CheckboxOptions({required this.onOptionSelected, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildCheckboxOption("Yes", context),
        const SizedBox(width: 10),
        _buildCheckboxOption("No", context),
        const SizedBox(width: 10),
        _buildCheckboxOption("In process", context),
      ],
    );
  }

  Widget _buildCheckboxOption(String label, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => Checkbox(
              value: controller.selectedOption.value == label,
              onChanged: (bool? value) {
                if (value == true) {
                  controller.updateSelectedOption(label);
                  onOptionSelected(true);
                }
              },
              activeColor: Color(0xFF35124E),
              checkColor: Color(0xFF35124E),
            )),
        Text(label,
            style: const TextStyle(color: Color(0xFFB0BEC5), fontSize: 16)),
      ],
    );
  }
}
