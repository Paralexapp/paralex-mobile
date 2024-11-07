import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/service_provider/view/signup_screens/widgets/custom_button.dart';
import 'package:paralax/service_provider/view/signup_screens/widgets/textfieldWidget.dart';

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
                        hintText: 'Full Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      TextfieldWidget(
                        hintText: 'Nick Name/Alias',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextfieldWidget(
                        hintText: 'Mobile Number',
                        keyboardType: TextInputType.number,
                      ),
                      TextfieldWidget(
                        hintText: 'Work phone No',
                      ),
                      TextfieldWidget(
                        hintText: 'Current home',
                      ),
                      TextfieldWidget(
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextfieldWidget(
                        hintText: 'Duration of stay e.g 2 years',
                      ),
                      TextfieldWidget(
                        hintText: 'Name of Landlord',
                      ),
                      TextfieldWidget(
                        hintText: 'How long in current state',
                      ),
                      TextfieldWidget(
                        hintText: 'How long resided in current city',
                      ),
                      TextfieldWidget(
                        hintText: 'Former residence address',
                      ),
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
  }
}
