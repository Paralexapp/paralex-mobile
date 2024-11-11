import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';

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
                      "Hello, Emmanuel John",
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
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.greenAccent,
                  PaintColors.paralaxpurple,
                  PaintColors.paralaxpurple,
                ],
              ),
              borderRadius:
                  BorderRadius.circular(16), // Optional: Rounded corners
            ),
            child: const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'LOGISTICS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: GestureDetector(
            onTap: () => Get.toNamed(Nav.paralegalHome),
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.25),
              width: size.width * 0.9,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    PaintColors.paralaxpurple,
                    Colors.greenAccent,
                  ],
                ),
                borderRadius:
                    BorderRadius.circular(16), // Optional: Rounded corners
              ),
              child: const Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'PARALEGAL',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
                      child: Center(
                        child: Icon(Iconsax.arrow_right_2),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
