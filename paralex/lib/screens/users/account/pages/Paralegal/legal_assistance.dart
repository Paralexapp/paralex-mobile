import 'package:flutter/material.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';

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
              .copyWith(color: PaintColors.paralaxpurple, fontSize: 14),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LegalServices(image: "assets/images/stamp.png", text: "NAFDAC"),
                LegalServices(
                  image: "assets/images/stamp.png",
                  text: "CAC",
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LegalServices(
                    image: "assets/images/stamp.png", text: "TRADEMARK"),
                LegalServices(
                  image: "assets/images/stamp.png",
                  text: "IMMIGRATION",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LegalServices extends StatelessWidget {
  const LegalServices({super.key, required this.image, required this.text});
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
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
    );
  }
}
