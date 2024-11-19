import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/service_provider/services/firebase_service.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final FirebaseService auth = FirebaseService();
  bool loading = false;
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
                      .copyWith(color: PaintColors.paralexpurple, fontSize: 25),
                ),
                Text("Enter the code we just sent",
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
                        color: PaintColors.paralexpurple,
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
                        color: PaintColors.paralexpurple,
                        letterSpacing: 0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text("to the registered phone number",
                    style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.paralexpurple,
                        letterSpacing: 0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async{
                    try{
                      setState(() {
                        loading = true;
                      });
                      await auth.checkEmailVerified();
                      setState(() {
                        loading = false;
                      });
                      Get.toNamed(Nav.verificationScreen);
                    }
                   catch(e){
                     setState(() {
                       loading = false;
                     });
                      log('$e');
                      Get.snackbar("Error", "$e");
                   }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: size.width * 0.85,
                    decoration: const BoxDecoration(
                        color: PaintColors.paralexpurple,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: loading == true ? Container(
                          width: 30,
                          height: 30,
                          padding: const EdgeInsets.all(2.0),
                          child:
                          const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ) : Text(
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
