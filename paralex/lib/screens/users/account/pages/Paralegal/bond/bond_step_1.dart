import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/service_provider/view/signup_screens/widgets/custom_button.dart';
import 'package:paralax/service_provider/view/signup_screens/widgets/textfieldWidget.dart';

class BondFirstStep extends StatelessWidget {
  const BondFirstStep({super.key});

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
                Text(
                  "You, the undersigned Defendant (\"defendant\" or \"you\" includes an accused person or a suspect), hereby represent and warrant that the following declarations made and answers given are true, complete and correct, and are made for the purpose of inducing Paralex Logistics Limited (\"surety\") to issue, or cause to be issued, bail bond(s) or undertaking(s) for you (singularly or collectively the \"Bond\"), in the total amount of.",
                  textAlign: TextAlign.justify, // Optional: Text alignment
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: PaintColors.generalTextsm,
                      fontSize: 12),
                  maxLines: 10, // Optional: Number of lines
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      TextfieldWidget(
                        // labelText: 'Full Name',
                        hintText: 'Enter bond amount',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      TextfieldWidget(
                        hintText: '10% Bail-bond fee',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextfieldWidget(
                        hintText: 'Court',
                      ),
                      TextfieldWidget(
                        hintText: 'Investigating agency',
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
