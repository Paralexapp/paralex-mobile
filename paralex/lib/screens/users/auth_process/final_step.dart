import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';

class FinalStep extends StatefulWidget {
  const FinalStep({super.key});

  @override
  State<FinalStep> createState() => _FinalStepState();
}

class _FinalStepState extends State<FinalStep> {
  @override
  Widget build(BuildContext context) {
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
                  "Congratulations",
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
                      "Your new password has",
                      style: FontStyles.smallCapsIntro.copyWith(
                          color: PaintColors.generalTextsm,
                          letterSpacing: 0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  textAlign: TextAlign.center,
                  "been sent",
                  style: FontStyles.smallCapsIntro.copyWith(
                      color: PaintColors.generalTextsm,
                      letterSpacing: 0,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.40,
                ),
                GestureDetector(
                  // onTap: () => Get.toNamed(Nav.tellusMoreforUsers),

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
