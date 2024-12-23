import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/utils/validator.dart';
import 'package:paralex/widgets/phone_number_inputfield.dart';

import '../../../../../../service_provider/controllers/bail_bond_service_controller.dart';
import '../../../../../../service_provider/view/widgets/custom_button.dart';
import '../../../../../../widgets/textfieldWidget.dart';

class BondSecondStep extends StatelessWidget {
  final BailBondServiceController controller = Get.put(BailBondServiceController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BondSecondStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PaintColors.bgColor,
        appBar: AppBar(
          title: Text(
            "Bail Bond Application Form",
            style: FontStyles.headingText
                .copyWith(color: PaintColors.paralexpurple, fontSize: 14),
          ),
          backgroundColor: PaintColors.bgColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextfieldWidget(
                        controller: controller.fullName,
                        hintText: 'Full Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      TextfieldWidget(
                        controller: controller.nickName,
                        hintText: 'Nick Name/Alias',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      PhoneNumberInputField(
                        hintText: 'Mobile Number',
                        onChanged: (phone) {
                          controller.phoneNumber.text = phone.completeNumber;
                        },
                      ),
                      PhoneNumberInputField(
                        hintText: 'Work phone No',
                        onChanged: (phone) {
                          controller.workPhoneNumber.text = phone.completeNumber;
                        },
                      ),
                      TextfieldWidget(
                        controller: controller.currentHomeAddress,
                        hintText: 'Current home',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      TextfieldWidget(
                        controller: controller.email,
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => Validators.email().call(value!),
                      ),
                      TextfieldWidget(
                        controller: controller.durationOfStay,
                        hintText: 'Duration of stay e.g 2 years',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      TextfieldWidget(
                        controller: controller.nameOfLandlord,
                        hintText: 'Name of Landlord',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      TextfieldWidget(
                        controller: controller.howLongInCurrentState,
                        hintText: 'How long in current state',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      TextfieldWidget(
                        controller: controller.howLongInResidingCity,
                        hintText: 'How long resided in current city',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      TextfieldWidget(
                        controller: controller.formerResidentAddress,
                        hintText: 'Former residence address',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                          desiredWidth: 90,
                          buttonText: "Next",
                          buttonColor: PaintColors.paralexpurple,
                          ontap: () {
                            if (!_formKey.currentState!.validate()) return;

                            controller.navigateToBondStep3();
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
