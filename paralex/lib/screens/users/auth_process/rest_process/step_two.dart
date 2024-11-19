import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';

class StepTwo extends StatefulWidget {
  const StepTwo({super.key});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
      ),
      backgroundColor: PaintColors.bgColor,
      body: Container(
        margin: EdgeInsets.only(top: size.height * 0.03),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        // color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Confirm your\nemail address",
                  style: FontStyles.headingText.copyWith(
                      color: PaintColors.paralexpurple,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                Text("Enter the login pin sent to your email",
                    style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.generalTextsm,
                        letterSpacing: 0,
                        // fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //01

                // const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 68,
                      width: 60,
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
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
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
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
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
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
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
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),

                //02
              ],
            )),
            InkWell(
              onTap: () => Get.toNamed(Nav.setNewPass),
              child: Text("Resend code",
                  style: FontStyles.smallCapsIntro.copyWith(
                      color: PaintColors.generalTextsm,
                      letterSpacing: 0,
                      // fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
