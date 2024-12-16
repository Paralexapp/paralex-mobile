import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/custom_text_form_field.dart';
import '../../reusables/back_button.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';
import '../controllers/guarantor_detail_controller.dart';

class GuarantorDetail extends StatelessWidget {
  final GuarantorDetailController controller =
      Get.put(GuarantorDetailController());
  GuarantorDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
        leading: IconButton(onPressed: Get.back, icon: PinkButton.backButton),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Guarantor's Detail",
                  style: FontStyles.headingText.copyWith(
                    color: PaintColors.paralexpurple,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Choose a guarantor",
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                ),
                CustomTextFormField(
                  hintText: "Parent",
                  ontap: controller.showGuarantorDialog,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                  readonly: true,
                  controller: controller.guarantorController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a guarantor'
                      : null,
                ),
                const SizedBox(height: 15),
                Text(
                  "Guarantor Phone number",
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                ),
                IntlPhoneField(
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xFFECF1F4),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  ),
                  initialCountryCode: 'NG',
                  onChanged: (phone) {
                    controller.phoneNumber.value = phone.completeNumber;
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  "Guarantor email",
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Guarantor email",
                  controller: controller.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!controller.isValidEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  "Guarantor state of residence",
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                ),
                CustomTextFormField(
                  hintText: "Lagos",
                  readonly: true,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                  ontap: controller.showNgStatesDialog,
                  controller: controller.stateController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a state'
                      : null,
                ),
                const SizedBox(height: 15),
                Text(
                  "Guarantor residential address",
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                ),
                CustomTextFormField(
                  hintText: "",
                  controller: controller.addressController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your residential address'
                      : null,
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
              CustomButton(
                desiredWidth: 0.85,
                buttonText: "CONTINUE",
                buttonColor: PaintColors.paralexpurple,
                ontap: controller.validateAndSubmit,
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
