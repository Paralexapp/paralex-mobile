import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/service_provider/view/signup_screens/widgets/custom_button.dart';
import 'package:paralax/service_provider/view/signup_screens/widgets/radion_btns.dart';
import 'package:paralax/service_provider/view/signup_screens/widgets/textfieldWidget.dart';

class BondThirdStep extends StatelessWidget {
  const BondThirdStep({super.key});

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.all(25),
          child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      TextfieldWidget(
                        // labelText: 'Full Name',
                        hintText: 'Date of birth',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      ReusableRadioButtons(
                        label: "   Gender",
                        options: const ['M', 'F'],
                        initialValue: 'M',
                        onChanged: (value) {},
                      ),
                      TextfieldWidget(
                        hintText: 'Place of Birth(City & State)',
                        keyboardType: TextInputType.number,
                      ),
                      TextfieldWidget(
                        hintText: 'Nationality',
                      ),
                      TextfieldWidget(
                        hintText: 'NIN',
                      ),
                      TextfieldWidget(
                        hintText: 'International Passport Number',
                      ),
                      TextfieldWidget(
                        hintText: 'Height',
                      ),
                      TextfieldWidget(
                        hintText: 'Weight',
                      ),
                      TextfieldWidget(
                        hintText: 'Eye color',
                      ),
                      ReusableRadioButtons(
                        label: "   Physical Challenge",
                        options: const ['Yes', 'No'],
                        initialValue: 'Yes',
                        onChanged: (value) {},
                      ),
                      TextfieldWidget(
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
                          ontap: () => Get.toNamed(Nav.bondStepB))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
    ;
  }
}
