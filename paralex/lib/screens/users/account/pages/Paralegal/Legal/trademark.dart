import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';

class TrademarkRegistration extends StatelessWidget {
  const TrademarkRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        title: Center(
          child: Text(
            "TRADEMARK",
            style: FontStyles.headingText
                .copyWith(color: PaintColors.paralexpurple, fontSize: 14),
          ),
        ),
        backgroundColor: PaintColors.bgColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/trademark_logo.jpeg',
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                      "Trademark.",
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
                      ontap: () => Get.toNamed(Nav.trademarkStepOne),
                      desiredWidth: 90,
                      buttonText: "Next",
                      buttonColor: PaintColors.paralexpurple)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
