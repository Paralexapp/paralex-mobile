import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';

import '../../../../../../service_provider/controllers/bail_bond_service_controller.dart';
import '../../../../../../service_provider/view/widgets/custom_button.dart';
import '../../../../../../service_provider/view/widgets/date_picker.dart';
import '../../../../../../service_provider/view/widgets/radion_btns.dart';
import '../../../../../../utils/validator.dart';
import '../../../../../../widgets/textfieldWidget.dart';

class BondThirdStep extends StatelessWidget {
  final BailBondServiceController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BondThirdStep({super.key});

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
                      ReusableDatePicker(
                        controller: controller.dateOfBirth,
                        labelText: "Date of birth",
                        onDateChanged: (date) {
                          // print('Selected date: $date');
                        },
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2020),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableRadioButtons(
                        label: "   Gender",
                        options: const ['M', 'F'],
                        initialValue: 'M',
                        onChanged: (value) {
                          if (value == 'M') {
                            controller.gender.text = 'Male'!;
                          } else {
                            controller.gender.text = 'Female'!;
                          }
                        },
                      ),
                      TextfieldWidget(
                        controller: controller.placeOfBirth,
                        hintText: 'Place of Birth(City & State)',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      TextfieldWidget(
                        controller: controller.nationality,
                        hintText: 'Nationality',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      TextfieldWidget(
                        controller: controller.nin,
                        hintText: 'NIN',
                        formatters: [LengthLimitingTextInputFormatter(11)],
                        validator: (value) => Validators.minLength(value, 10),
                      ),
                      TextfieldWidget(
                        controller: controller.internationalPassportNumber,
                        hintText: 'International Passport Number',
                        validator: (val) {
                          return null;
                        },
                      ),
                      TextfieldWidget(
                        controller: controller.height,
                        hintText: 'Height',
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        formatters: [
                          FilteringTextInputFormatter(RegExp(r"[0-9.]"), allow: true),
                        ],
                      ),
                      TextfieldWidget(
                        controller: controller.weight,
                        hintText: 'Weight',
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        formatters: [
                          FilteringTextInputFormatter(RegExp(r"[0-9.]"), allow: true),
                        ],
                      ),
                      TextfieldWidget(
                        controller: controller.eyeColor,
                        hintText: 'Eye color',
                        validator: (val) {
                          return null;
                        },
                      ),
                      ReusableRadioButtons(
                        label: "   Physical Challenge",
                        options: const ['Yes', 'No'],
                        initialValue: 'Yes',
                        onChanged: (value) {
                          if (value?.toLowerCase() == "yes") {
                            controller.physicallyChallenged(true);
                          } else {
                            controller.physicallyChallenged(false);
                          }
                        },
                      ),
                      TextfieldWidget(
                        controller: controller.memberOfAnyGroup,
                        hintText: 'Member of any group',
                        validator: (val) {
                          return null;
                        },
                      ),
                      // TextfieldWidget(
                      //   hintText: 'How long resided in current city',
                      // ),
                      // TextfieldWidget(
                      //   hintText: 'Former residence address',
                      // ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                          desiredWidth: 90,
                          buttonText: "Next",
                          buttonColor: PaintColors.paralexpurple,
                          ontap: () {
                            if (!_formKey.currentState!.validate()) return;
                            controller.navigateToBondStep4();
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
