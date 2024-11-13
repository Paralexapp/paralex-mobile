import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';

class LegalAssistance extends StatelessWidget {
  const LegalAssistance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
        title: Text(
          "Bail Bond Application Form",
          style: FontStyles.headingText
              .copyWith(color: PaintColors.paralexpurple, fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LegalServices(
                  image: "assets/images/stamp.png",
                  text: "NAFDAC",
                  ontap: () => Get.toNamed(Nav.nafdacReg),
                ),
                LegalServices(
                  ontap: () => Get.toNamed(Nav.nafdacReg),
                  image: "assets/images/stamp.png",
                  text: "CAC",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LegalServices(
                    ontap: () => Get.toNamed(Nav.nafdacReg),
                    image: "assets/images/stamp.png",
                    text: "TRADEMARK"),
                LegalServices(
                  ontap: () => Get.toNamed(Nav.nafdacReg),
                  image: "assets/images/stamp.png",
                  text: "IMMIGRATION",
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  color: PaintColors.white,
                  borderRadius: BorderRadius.circular(20)
                  // Optional: Rounded corners
                  ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/law.png",
                          height: 40,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery to Ikoyi Supreme court",
                              style: FontStyles.headingText.copyWith(
                                  fontSize: 15,
                                  color: PaintColors.generalTextsm),
                            ),
                            Text(
                              "SEPTEMBER 16 . 8:00AM",
                              style: FontStyles.headingText.copyWith(
                                  fontSize: 12,
                                  color: PaintColors.generalTextsm),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 200,
                                ),
                                Text(
                                  "Submitted",
                                  style: FontStyles.headingText.copyWith(
                                      fontSize: 12,
                                      color: PaintColors.generalTextsm),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LegalServices extends StatelessWidget {
  const LegalServices(
      {super.key,
      required this.ontap,
      required this.image,
      required this.text});
  final String text;
  final String image;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ontap,
      child: Container(
        width: size.width * 0.40,
        height: 150,
        decoration: BoxDecoration(
            color: PaintColors.fadedPinkBg,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [Image.asset(image), Text(text)],
          ),
        ),
      ),
    );
  }
}
