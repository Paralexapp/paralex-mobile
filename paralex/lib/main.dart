import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paralax/routes/navs.dart';
import 'package:paralax/screens/splash/splash.dart';
import 'package:paralax/screens/users/account/home.dart';
import 'package:paralax/screens/users/account/pages/Paralegal/Legal/nafdac.dart';
import 'package:paralax/screens/users/account/pages/Paralegal/bond/bond_step_1.dart';
import 'package:paralax/screens/users/account/pages/Paralegal/bond/bond_step_2.dart';
import 'package:paralax/screens/users/account/pages/Paralegal/bond/bond_step_3.dart';
import 'package:paralax/screens/users/account/pages/Paralegal/bond/bond_step_4.dart';
import 'package:paralax/screens/users/account/pages/Paralegal/bond/bond_step_5.dart';
import 'package:paralax/screens/users/account/pages/Paralegal/bond/bond_success.dart';
import 'package:paralax/screens/users/account/pages/Paralegal/Legal/legal_assistance.dart';
import 'package:paralax/screens/users/account/pages/Paralegal/paralegal_home.dart';
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
      GetPage(
          name: Nav.lastWelcomeScreen, page: () => const LastWelcomeScreen()),
      GetPage(
          name: Nav.serviceProviderSignupWelcomeScreen,
          page: () => SignupWelcomeScreen()),
      GetPage(
          name: Nav.selectServiceScreen,
          page: () => const SelectServiceScreen()),
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
      GetPage(name: Nav.aboutServiceProvider, page: () => AboutYou()),
      GetPage(name: Nav.aboutServiceProviderPage2, page: () => AboutYouContd()),
      GetPage(name: Nav.guarantorDetail, page: () => GuarantorDetail()),
      GetPage(name: Nav.login, page: () => const LoginWithPassword()),
      GetPage(name: Nav.forgotPassword, page: () => const StepOne()),
      GetPage(name: Nav.resetPassOtp, page: () => const StepTwo()),
      GetPage(name: Nav.setNewPass, page: () => const StepThree()),
      GetPage(name: Nav.finalStep, page: () => const FinalStep()),
      GetPage(name: Nav.home, page: () => const Home()),
      GetPage(name: Nav.paralegalHome, page: () => const ParalegalDashboard()),
      GetPage(name: Nav.bondStepA, page: () => const BondFirstStep()),
      GetPage(name: Nav.bondStepB, page: () => const BondSecondStep()),
      GetPage(name: Nav.bondStepC, page: () => const BondThirdStep()),
      GetPage(name: Nav.bondStepD, page: () => const BondFourthStep()),
      GetPage(name: Nav.bondStepE, page: () => const BondStepFive()),
      GetPage(name: Nav.bondSubmitted, page: () => const BondSuccess()),
      GetPage(name: Nav.legalServiceHome, page: () => const LegalAssistance()),
      GetPage(name: Nav.nafdacReg, page: () => const NafdacRegistration())
    ],
    debugShowCheckedModeBanner: false,
  ));
}
