import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:get/get.dart';
import 'package:paralax/service_provider/controllers/user_choice_controller.dart';

import '../../../routes/navs.dart';

class VerificationMessage extends StatefulWidget {
  const VerificationMessage({super.key});

  @override
  State<VerificationMessage> createState() => _VerificationMessageState();
}

class _VerificationMessageState extends State<VerificationMessage> {
  @override
  Widget build(BuildContext context) {
    final userChoiceController = Get.find<UserChoiceController>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.30),
            child: Column(
              children: [
                Text(
                  "Verification Sent!",
                  style: FontStyles.headingText
                      .copyWith(color: PaintColors.paralaxpurple, fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/Emoji.svg",
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Your pin is personal to you. Do\n not share with anyone to ensure\n your account saftey",
                      style: FontStyles.smallCapsIntro.copyWith(
                          color: PaintColors.generalTextsm,
                          letterSpacing: 0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.40,
                ),
                GestureDetector(
                  // onTap: () => Get.toNamed(Nav.tellusMoreforUsers),
                  onTap: () {
                    if (userChoiceController.isUser.value) {
                      Get.toNamed(
                          Nav.tellusMoreforUsers); // Navigate to UserHomeScreen
                    } else {
                      Get.toNamed(Nav
                          .selectServiceScreen); // Navigate to ServiceProviderHomeScreen
                    }
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: size.width * 0.85,
                    decoration: const BoxDecoration(
                        color: PaintColors.paralaxpurple,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      "OKAY",
                      style: FontStyles.smallCapsIntro.copyWith(
                          color: Colors.white,
                          letterSpacing: 0,
                          fontSize: 15,
                          fontWeight: FontWeight.w800),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
