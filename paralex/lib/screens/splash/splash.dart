import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paralax/routes/navs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(Nav.welcomeShow);
    });
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Container(
        color: PaintColors.paralaxpurple,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.9,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/logo.svg",
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        " LOGISTICS . PARALEGAL",
                        style: FontStyles.smallCapsIntro,
                      ),
                    ],
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
