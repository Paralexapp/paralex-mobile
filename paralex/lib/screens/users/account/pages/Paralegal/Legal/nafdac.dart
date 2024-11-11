import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/service_provider/view/widgets/custom_button.dart';

class NafdacRegistration extends StatelessWidget {
  const NafdacRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        title: Center(
          child: Text(
            "NAFDAC",
            style: FontStyles.headingText
                .copyWith(color: PaintColors.paralaxpurple, fontSize: 14),
          ),
        ),
        backgroundColor: PaintColors.bgColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/nafdac.png',
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                      "The National Agency for Food and Drug Administration and Control (NAFDAC) is a Nigerian federal agency under the Federal Ministry of Health that is responsible for regulating and controlling the manufacture, importation, exportation, advertisement, distribution, sale, and use of food, drugs, cosmetics, medical devices, chemicals, and packaged water.",
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.visible,
                      maxLines: null,
                      style: FontStyles.smallCapsIntro.copyWith(
                          letterSpacing: 0, color: PaintColors.generalTextsm)),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    color: Color(0xAAE4E4E4),
                    height: 1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Duration",
                          style: FontStyles.smallCapsIntro.copyWith(
                              letterSpacing: 0,
                              color: PaintColors.generalTextsm)),
                      Text("3 Weeks",
                          style: FontStyles.smallCapsIntro.copyWith(
                              letterSpacing: 0,
                              color: PaintColors.generalTextsm)),
                    ],
                  ),
                  Container(
                    color: Color(0xAAE4E4E4),
                    height: 1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Cost",
                          style: FontStyles.smallCapsIntro.copyWith(
                              letterSpacing: 0,
                              color: PaintColors.generalTextsm)),
                      Text("300,000",
                          style: FontStyles.smallCapsIntro.copyWith(
                              letterSpacing: 0,
                              color: PaintColors.generalTextsm)),
                    ],
                  ),
                  Container(
                    color: const Color(0xAAE4E4E4),
                    height: 1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Number of Documents",
                          style: FontStyles.smallCapsIntro.copyWith(
                              letterSpacing: 0,
                              color: PaintColors.generalTextsm)),
                      Text("24",
                          style: FontStyles.smallCapsIntro.copyWith(
                              letterSpacing: 0,
                              color: PaintColors.generalTextsm)),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      ontap: () => Get.toNamed(Nav.nafdacStepOne),
                      desiredWidth: 90,
                      buttonText: "Next",
                      buttonColor: PaintColors.paralaxpurple)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
