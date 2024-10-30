import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: size.height * 0.30),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  "Verification",
                  style: FontStyles.headingText
                      .copyWith(color: PaintColors.paralaxpurple, fontSize: 25),
                ),
                Text("Enter the code you just sent",
                    style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.generalTextsm,
                        letterSpacing: 0,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                Text("you on your email",
                    style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.generalTextsm,
                        letterSpacing: 0,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //01
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 68,
                        width: 68,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 68,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 68,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 68,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      )
                    ],
                  ),
                )

                //02
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't recieve code?",
                    style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.generalTextsm,
                        letterSpacing: 0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text(" Resend",
                    style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.paralaxpurple,
                        letterSpacing: 0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: size.height * 0.19,
            ),
            Column(
              children: [
                Text("Verification codes are only sent",
                    style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.paralaxpurple,
                        letterSpacing: 0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text("to the registered phone number",
                    style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.paralaxpurple,
                        letterSpacing: 0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Nav.verificationScreen),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: size.width * 0.85,
                    decoration: const BoxDecoration(
                        color: PaintColors.paralaxpurple,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      "CONTINUE",
                      style: FontStyles.smallCapsIntro.copyWith(
                          color: Colors.white,
                          letterSpacing: 0,
                          fontSize: 15,
                          fontWeight: FontWeight.w800),
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
