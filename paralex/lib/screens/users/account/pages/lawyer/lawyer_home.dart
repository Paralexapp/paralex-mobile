import 'package:flutter/material.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/service_provider/view/signup_screens/widgets/textfieldWidget.dart';

class LawyerHome extends StatelessWidget {
  const LawyerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.white,
      appBar: AppBar(
        backgroundColor: PaintColors.white,
        title: Center(
          child: Text(
            "Get a Lawyer",
            style: FontStyles.headingText
                .copyWith(color: PaintColors.paralexpurple, fontSize: 14),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Find a lawyer",
              style: FontStyles.headingText
                  .copyWith(color: PaintColors.paralexpurple, fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextfieldWidget(
              hintText: "Find a lawyer",
            ),
            const SizedBox(
              height: 10,
            ),
            //Extract this into a widget as Tabs....
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PaintColors.fadedPinkBg),
                  child: const Text("COPERATE"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PaintColors.fadedPinkBg),
                  child: const Text("LAND LAW"),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PaintColors.fadedPinkBg),
                  child: const Text("FAMILY"),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              color: Color(0xAAE4E4E4),
              height: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            //Extract into a list...
            const Lawyers(),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Color(0xAAE4E4E4),
              height: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            //Extract into a list...
            const Lawyers(),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Color(0xAAE4E4E4),
              height: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            //Extract into a list...
            const Lawyers(),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Color(0xAAE4E4E4),
              height: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            //Extract into a list...
            const Lawyers(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class Lawyers extends StatelessWidget {
  const Lawyers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.asset(
            'assets/images/law.png',
            height: 60,
            width: 60,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Jubril Onikoyi",
                style: FontStyles.headingText
                    .copyWith(color: PaintColors.paralexpurple, fontSize: 20),
              ),
              Text(
                "Land Law",
                style: FontStyles.smallCapsIntro.copyWith(
                    letterSpacing: 0,
                    fontSize: 12,
                    color: PaintColors.generalTextsm),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 10,
                    color: Color(0xAAFFC403),
                  ),
                  Row(
                    children: [
                      Text(
                        "4.7 (122Reviews)",
                        style: FontStyles.smallCapsIntro.copyWith(
                            letterSpacing: 0,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: PaintColors.generalTextsm),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                        "N500 per hour",
                        style: FontStyles.smallCapsIntro.copyWith(
                            letterSpacing: 0,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: PaintColors.generalTextsm),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
