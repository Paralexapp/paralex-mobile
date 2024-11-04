import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paralax/routes/navs.dart';
import 'package:paralax/screens/splash/splash.dart';
import 'package:paralax/screens/users/auth_process/final_step.dart';
import 'package:paralax/screens/users/auth_process/login.dart';
import 'package:paralax/screens/users/auth_process/registration.dart';
import 'package:paralax/screens/users/auth_process/otp.dart';
import 'package:paralax/screens/users/auth_process/rest_process/step_one.dart';
import 'package:paralax/screens/users/auth_process/rest_process/step_three.dart';
import 'package:paralax/screens/users/auth_process/rest_process/step_two.dart';
import 'package:paralax/screens/users/auth_process/tellus_more.dart';
import 'package:paralax/screens/users/auth_process/verification_message.dart';
import 'package:paralax/screens/welcomeslides/last_welcome_screen.dart';
import 'package:paralax/screens/welcomeslides/welcome.dart';
import 'package:paralax/service_provider/controllers/user_choice_controller.dart';
import 'package:paralax/service_provider/view/signup_screens/select_service_screen.dart';
import 'package:paralax/service_provider/view/signup_screens/signup_welcome_screen.dart';

void main() {
  Get.put(UserChoiceController());
  runApp(GetMaterialApp(
    initialRoute: Nav.splash,
    getPages: [
      GetPage(name: Nav.splash, page: () => const SplashScreen()),
      GetPage(name: Nav.welcomeShow, page: () => const WelcomeSliders()),
      GetPage(
          name: Nav.lastWelcomeScreen, page: () => const LastWelcomeScreen()),
      GetPage(
          name: Nav.serviceProviderSignupWelcomeScreen,
          page: () => SignupWelcomeScreen()),
      GetPage(
          name: Nav.selectServiceScreen,
          page: () => const SelectServiceScreen()),
      GetPage(
          name: Nav.lastWelcomeScreen, page: () => const LastWelcomeScreen()),
      GetPage(
          name: Nav.serviceProviderSignupWelcomeScreen,
          page: () => SignupWelcomeScreen()),
      GetPage(
          name: Nav.selectServiceScreen,
          page: () => const SelectServiceScreen()),
      GetPage(name: Nav.userSignupScreen, page: () => const UserRegistration()),
      GetPage(name: Nav.otpScreen, page: () => const OtpVerification()),
      GetPage(
          name: Nav.verificationScreen,
          page: () => const VerificationMessage()),
      GetPage(name: Nav.tellusMoreforUsers, page: () => const MoreAboutYou()),
      GetPage(name: Nav.login, page: () => const LoginWithPassword()),
      GetPage(name: Nav.forgotPassword, page: () => const StepOne()),
      GetPage(name: Nav.resetPassOtp, page: () => const StepTwo()),
      GetPage(name: Nav.setNewPass, page: () => const StepThree()),
      GetPage(name: Nav.finalStep, page: () => const FinalStep())
    ],
    debugShowCheckedModeBanner: false,
  ));
}
