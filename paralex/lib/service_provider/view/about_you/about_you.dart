// about_you.dart
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../reusables/back_button.dart';
import '../../../reusables/fonts.dart';
import '../../../reusables/paints.dart';
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
      backgroundColor: PaintColors.bgColor,
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
                    color: PaintColors.paralexpurple,
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
                      controller: controller.firstName,
                      hintText: 'First name',
                      labelText: 'First name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your First name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.lastName,
                      hintText: 'Last name',
                      labelText: 'Last name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your last name";
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
                      decoration: const InputDecoration(
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
                      hintText: 'Date Of birth',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select your date of birth";
                        }
                        return null;
                      },
                      suffixIcon: const Icon(Icons.calendar_today),
                      //onSuffixTap: () => controller.onDateOfBirthTap(context),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: "Lagos",
                      labelText: "State of residence",
                      readonly: true,
                      suffixIcon:
                          const Icon(Icons.keyboard_arrow_down_outlined),
                      ontap: controller.showNgStatesDialog,
                      controller: controller.stateController,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please select a state'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    Text("Upload passport",
                        style: FontStyles.smallCapsIntro.copyWith(
                            letterSpacing: 0,
                            color: Color(0xFF868686),
                            fontSize: 15)),
                    const SizedBox(height: 15),
                    Center(
                      child: GestureDetector(
                        onTap: controller.passportImage.value == null
                            ? controller.pickImage
                            : null,
                        child: SizedBox(
                          height: 113,
                          child: DottedBorder(
                            color: Colors.grey,
                            strokeWidth: 1,
                            dashPattern: [6, 4],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(8),
                            child: Stack(
                              children: [
                                Center(
                                  child: Obx(() {
                                    return controller.passportImage.value ==
                                            null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.insert_drive_file,
                                                color: Colors.grey[400],
                                                size: 50,
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                'Upload File',
                                                style: FontStyles.smallCapsIntro
                                                    .copyWith(
                                                        letterSpacing: 0,
                                                        color: PaintColors
                                                            .paralexpurple,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                'Supports Jpg',
                                                style: FontStyles.smallCapsIntro
                                                    .copyWith(
                                                        letterSpacing: 0,
                                                        color:
                                                            Color(0xFF999999),
                                                        fontSize: 10),
                                              ),
                                            ],
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              controller.passportImage.value!,
                                              fit: BoxFit.cover,
                                              height: double.infinity,
                                            ),
                                          );
                                  }),
                                ),
                                Obx(() {
                                  return controller.passportImage.value != null
                                      ? Positioned(
                                          bottom: 4,
                                          right: 4,
                                          child: GestureDetector(
                                            onTap: controller.removeImage,
                                            child: _deleteIcon(),
                                          ),
                                        )
                                      : SizedBox.shrink();
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Do you have a rider card?",
                      style: FontStyles.smallCapsIntro.copyWith(
                          letterSpacing: 0,
                          color: const Color(0xFF868686),
                          fontSize: 15),
                    ),
                    CheckboxOptions(
                      controller: controller,
                      onOptionSelected: controller.onCheckboxChanged,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Custom Button
                  Obx(() => CustomButton(
                    desiredWidth: 0.85,
                    buttonText: controller.isLoading.value ? "" : "CONTINUE",
                    buttonColor: PaintColors.paralexpurple,
                    ontap: controller.onContinueButtonPressed,
                  )),
                  // Circular Progress Indicator
                  Obx(() => controller.isLoading.value
                      ? Positioned(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                      : const SizedBox.shrink()),
                ],
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
                              color: PaintColors.paralexpurple,
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
        ),
      ),
    );
  }
}

class CheckboxOptions extends StatelessWidget {
  final Function(bool) onOptionSelected;
  final AboutYouController controller;

  const CheckboxOptions(
      {super.key, required this.onOptionSelected, required this.controller});

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
              activeColor: const Color(0xFF35124E),
              checkColor: const Color(0xFF35124E),
            )),
        Text(label,
            style: const TextStyle(color: Color(0xFFB0BEC5), fontSize: 16)),
      ],
    );
  }
}

Widget _deleteIcon() => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      child: Icon(
        Icons.close,
        color: Colors.white,
        size: 20,
      ),
    );
