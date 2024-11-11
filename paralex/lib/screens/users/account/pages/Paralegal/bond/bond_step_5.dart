import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/service_provider/view/signup_screens/widgets/textfieldWidget.dart';
import 'package:paralax/service_provider/view/widgets/custom_button.dart';

class BondStepFive extends StatelessWidget {
  const BondStepFive({super.key});

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
          padding: const EdgeInsets.all(25),
          child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("EMPLOYMENT"),
                      const SizedBox(
                        height: 10,
                      ),
                      const TextfieldWidget(
                        hintText: 'Occupation 1',
                        keyboardType: TextInputType.text,
                      ),
                      const TextfieldWidget(
                        hintText: 'Occupation 2',
                        keyboardType: TextInputType.text,
                      ),
                      const TextfieldWidget(
                        hintText: 'Occupation 3',
                        keyboardType: TextInputType.text,
                      ),
                      const TextfieldWidget(
                        hintText: 'Occupation 4',
                        keyboardType: TextInputType.text,
                      ),
                      const TextfieldWidget(
                        hintText: 'Occupation 5',
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TextfieldWidget(
                        hintText: 'Current employers name',
                      ),
                      const TextfieldWidget(
                        hintText: 'How long',
                      ),
                      const TextfieldWidget(
                        hintText: 'Postiton',
                      ),
                      const TextfieldWidget(
                        hintText: 'Supervisors name',
                      ),
                      const TextfieldWidget(
                        hintText: 'Work phone',
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                          desiredWidth: 90,
                          buttonText: "SUBMIT",
                          buttonColor: PaintColors.paralaxpurple,
                          ontap: () => Get.toNamed(Nav.bondSubmitted))
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
