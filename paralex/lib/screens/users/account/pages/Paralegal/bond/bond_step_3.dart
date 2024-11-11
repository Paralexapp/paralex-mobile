import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';

import 'package:paralax/service_provider/view/signup_screens/widgets/textfieldWidget.dart';

import '../../../../../../service_provider/view/widgets/custom_button.dart';
import '../../../../../../service_provider/view/widgets/date_picker.dart';
import '../../../../../../service_provider/view/widgets/radion_btns.dart';

class BondThirdStep extends StatelessWidget {
  const BondThirdStep({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _dateController = TextEditingController();
    return Scaffold(
        backgroundColor: PaintColors.bgColor,
        appBar: AppBar(
          title: Text(
            "Bail Bond Application Form",
            style: FontStyles.headingText
                .copyWith(color: PaintColors.paralaxpurple, fontSize: 14),
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
                  child: Column(
                    children: [
                      ReusableDatePicker(
                        controller: _dateController,
                        labelText: "Date of birth",
                        onDateChanged: (date) {
                          // print('Selected date: $date');
                        },
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2025),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableRadioButtons(
                        label: "   Gender",
                        options: const ['M', 'F'],
                        initialValue: 'M',
                        onChanged: (value) {},
                      ),
                      const TextfieldWidget(
                        hintText: 'Place of Birth(City & State)',
                        keyboardType: TextInputType.number,
                      ),
                      const TextfieldWidget(
                        hintText: 'Nationality',
                      ),
                      const TextfieldWidget(
                        hintText: 'NIN',
                      ),
                      const TextfieldWidget(
                        hintText: 'International Passport Number',
                      ),
                      const TextfieldWidget(
                        hintText: 'Height',
                      ),
                      const TextfieldWidget(
                        hintText: 'Weight',
                      ),
                      const TextfieldWidget(
                        hintText: 'Eye color',
                      ),
                      ReusableRadioButtons(
                        label: "   Physical Challenge",
                        options: const ['Yes', 'No'],
                        initialValue: 'Yes',
                        onChanged: (value) {},
                      ),
                      const TextfieldWidget(
                        hintText: 'Member of any group',
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
                          buttonColor: PaintColors.paralaxpurple,
                          ontap: () => Get.toNamed(Nav.bondStepD))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
