import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/service_provider/view/widgets/activity_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "monday, Nov8, 2025 ",
                      style: FontStyles.smallCapsIntro.copyWith(
                          color: PaintColors.paralaxpurple,
                          fontSize: 14,
                          letterSpacing: 0),
                    ),
                    Text(
                      "Hello, Lagbaja a",
                      style: FontStyles.headingText.copyWith(
                          color: PaintColors.paralaxpurple,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    )
                  ],
                ),
                const Icon(
                  Iconsax.sms,
                  color: PaintColors.paralaxpurple,
                  size: 30,
                )
              ],
            ),
          ),
        ),
        //01

        Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.12),
            width: size.width * 0.9,
            height: 100,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('assets/images/paralegal.png')),
              borderRadius:
                  BorderRadius.circular(16), // Optional: Rounded corners
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: GestureDetector(
            onTap: () => Get.toNamed(Nav.paralegalHome),
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.22),
              width: size.width,
              height: 150,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('assets/images/log2.png')),
                borderRadius:
                    BorderRadius.circular(16), // Optional: Rounded corners
              ),
            ),
          ),
        ),

        Positioned(
          // top: size.height * 0.40,
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.48),
            width: size.width,
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.purple,
                  PaintColors.paralaxpurple,
                ],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)), // Optional: Rounded corners
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: size.height * 0.40),
            child: Image.asset("assets/images/law.png")),
        Positioned(
          right: 70,
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Need Lagal service?",
                  style: FontStyles.smallCapsIntro.copyWith(
                      color: PaintColors.white,
                      letterSpacing: 0,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "Hire a lawyer",
                      style: FontStyles.headingText.copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                          color: PaintColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: Icon(Iconsax.arrow_right_2),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          // top: size.height * 0.40,
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.58),
            width: size.width,
            height: 50,
            decoration: const BoxDecoration(
              color: PaintColors.bgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)), // Optional: Rounded corners
            ),
          ),
        ),
        // const Text("Activities"),
        Positioned(
          // top: size.height * 0.65,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.60),
              // padding: EdgeInsets.all(),
              width: size.width * 0.9,
              height: 100,
              decoration: BoxDecoration(
                  color: PaintColors.white,
                  borderRadius: BorderRadius.circular(20)
                  // Optional: Rounded corners
                  ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/law.png",
                          height: 40,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Delivery to Ikoyi Supreme court"),
                            Text("SEPTEMBER 16 . 8:00AM"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200,
                                ),
                                Text("Sbmitted")
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
          ),
        ),
      ],
    ));
  }
}
