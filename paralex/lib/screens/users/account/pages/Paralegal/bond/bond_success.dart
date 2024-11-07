import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';

import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/service_provider/view/signup_screens/widgets/custom_button.dart';

class BondSuccess extends StatelessWidget {
  const BondSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                color: PaintColors.paralaxpurple,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                  child: Image.asset(
                "assets/images/high-five.png",
                fit: BoxFit.cover,
              )),
            ),
            SizedBox(height: 10),
            Text(
              "Congratulations!",
              style: FontStyles.headingText.copyWith(color: Colors.black),
            ),
            Text(
              "your! submission was successful ",
              style: FontStyles.smallCapsIntro.copyWith(
                  color: Colors.black, letterSpacing: 0, fontSize: 14),
            ),
            SizedBox(height: 40),
            CustomButton(
                desiredWidth: 70,
                buttonText: "Go back to home ",
                buttonColor: PaintColors.paralaxpurple,
                ontap: () => Get.toNamed(Nav.paralegalHome))
          ],
        ),
      ),
    );
  }
}
