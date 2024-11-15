import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/service_provider/view/signup_screens/widgets/textfieldWidget.dart';

import '../../../../../../service_provider/view/widgets/custom_button.dart';

class BondSecondStep extends StatelessWidget {
  const BondSecondStep({super.key});

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
                  child: Column(
                    children: [
                      TextfieldWidget(
                        // labelText: 'Full Name',
                        hintText: 'Full Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      const TextfieldWidget(
                        hintText: 'Nick Name/Alias',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const TextfieldWidget(
                        hintText: 'Mobile Number',
                        keyboardType: TextInputType.number,
                      ),
                      const TextfieldWidget(
                        hintText: 'Work phone No',
                      ),
                      const TextfieldWidget(
                        hintText: 'Current home',
                      ),
                      const TextfieldWidget(
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const TextfieldWidget(
                        hintText: 'Duration of stay e.g 2 years',
                      ),
                      const TextfieldWidget(
                        hintText: 'Name of Landlord',
                      ),
                      const TextfieldWidget(
                        hintText: 'How long in current state',
                      ),
                      const TextfieldWidget(
                        hintText: 'How long resided in current city',
                      ),
                      const TextfieldWidget(
                        hintText: 'Former residence address',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                          desiredWidth: 90,
                          buttonText: "Next",
                          buttonColor: PaintColors.paralexpurple,
                          ontap: () => Get.toNamed(Nav.bondStepC))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
