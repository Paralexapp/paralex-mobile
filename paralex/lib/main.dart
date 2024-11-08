import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/screens/splash/splash.dart';
import 'package:paralax/screens/users/Authprocess/registration.dart';
import 'package:paralax/screens/users/Authprocess/otp.dart';
import 'package:paralax/screens/users/Authprocess/tellus_more.dart';
import 'package:paralax/screens/users/Authprocess/verification_message.dart';
import 'package:paralax/screens/welcomeslides/last_welcome_screen.dart';
import 'package:paralax/screens/welcomeslides/welcome.dart';
import 'package:paralax/service_provider/controllers/user_choice_controller.dart';
import 'package:paralax/service_provider/view/about_you/about_you.dart';
import 'package:paralax/service_provider/view/about_you/about_you_contd.dart';
import 'package:paralax/service_provider/view/guarantor_detail.dart';
import 'package:paralax/service_provider/view/signup_screens/select_service_screen.dart';
import 'package:paralax/service_provider/view/signup_screens/signup_welcome_screen.dart';

void main() {
  Get.put(UserChoiceController());
  runApp(GetMaterialApp(
    initialRoute: Nav.splash,
    getPages: [
      GetPage(name: Nav.splash, page: () => const SplashScreen()),
      GetPage(name: Nav.welcomeShow, page: () => const WelcomeSliders()),
      GetPage(name: Nav.lastWelcomeScreen, page: () => const LastWelcomeScreen()),
      GetPage(name: Nav.serviceProviderSignupWelcomeScreen, page: () => SignupWelcomeScreen()),
      GetPage(name: Nav.selectServiceScreen, page: () => const SelectServiceScreen()),
      GetPage(name: Nav.lastWelcomeScreen, page: () => const LastWelcomeScreen()),
      GetPage(name: Nav.serviceProviderSignupWelcomeScreen, page: () =>  SignupWelcomeScreen()),
      GetPage(name: Nav.selectServiceScreen, page: () =>  const SelectServiceScreen()),
      GetPage(name: Nav.userSignupScreen, page: () => const UserRegistration()),
      GetPage(name: Nav.otpScreen, page: () => const OtpVerification()),
      GetPage(name: Nav.verificationScreen, page: () => const VerificationMessage()),
      GetPage(name: Nav.tellusMoreforUsers, page: () => const MoreAboutYou()),
      GetPage(name: Nav.aboutServiceProvider, page: () => AboutYou()),
      GetPage(name: Nav.aboutServiceProviderPage2, page: () => AboutYouContd()),
      GetPage(name: Nav.guarantorDetail, page: () =>  GuarantorDetail()),

    ],
    debugShowCheckedModeBanner: false,
  ));
}
