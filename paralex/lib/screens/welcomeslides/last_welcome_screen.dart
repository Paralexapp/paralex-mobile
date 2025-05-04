import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paralex/reusables/fonts.dart';
import 'package:flutter_svg/svg.dart';
import '../../routes/navs.dart';

import '../../service_provider/controllers/user_choice_controller.dart';

class LastWelcomeScreen extends StatelessWidget {
  const LastWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userChoiceController = Get.find<UserChoiceController>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/new_lady.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.center,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Color(0x2035124E),
                  Color(0xFF35124E),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.60,
            left: size.width * 0.05,
            child: SizedBox(
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
          ),
          Positioned(
            top: size.height * 0.75,
            child: SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      userChoiceController.selectUser();
                      Get.toNamed(Nav.serviceProviderSignupWelcomeScreen);
                    },
                    child: const ParticipantWidget(
                      imgPath: "assets/images/2user.svg",
                      firstText: "User",
                      secondText: "Need a paralegal",
                      thirdText: "service?",
                    ),
                  ),
                  const SizedBox(width: 35),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Nav.selectServiceScreen);
                    },
                    child: const ParticipantWidget(
                      imgPath: "assets/images/medal-star.svg",
                      firstText: "Offer Service",
                      secondText: "Rider",
                      thirdText: "or Lawyer",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: size.height * 0.94,
              left: size.width * 0.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: FontStyles.smallCapsIntro
                        .copyWith(letterSpacing: 0, fontSize: 14),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Nav.login),
                    child: Text(
                      "Sign in",
                      style: FontStyles.smallCapsIntro.copyWith(
                          letterSpacing: 0,
                          fontWeight: FontWeight.w900,
                          fontSize: 14),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class ParticipantWidget extends StatelessWidget {
  const ParticipantWidget(
      {super.key,
      required this.imgPath,
      required this.firstText,
      required this.secondText,
      required this.thirdText});

  final String imgPath;
  final String firstText;
  final String secondText;
  final String thirdText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF4C1044),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(imgPath),
          Text(
            firstText,
            style: FontStyles.smallCapsIntro
                .copyWith(letterSpacing: 0, fontWeight: FontWeight.bold),
          ),
          Text(
            secondText,
            style: FontStyles.smallCapsIntro.copyWith(
              letterSpacing: 0,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -5),
            child: Text(
              thirdText,
              style: FontStyles.smallCapsIntro.copyWith(
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
