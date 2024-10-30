import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/screens/splash/splash.dart';
import 'package:paralax/screens/welcomeslides/last_welcome_screen.dart';
import 'package:paralax/screens/welcomeslides/welcome.dart';
import 'package:paralax/service_provider/view/signup_screens/select_service_screen.dart';
import 'package:paralax/service_provider/view/signup_screens/signup_welcome_screen.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: Nav.splash,
    getPages: [
      GetPage(name: Nav.splash, page: () => const SplashScreen()),
      GetPage(name: Nav.welcomeShow, page: () => const WelcomeSliders()),
      GetPage(name: Nav.lastWelcomeScreen, page: () => const LastWelcomeScreen()),
      GetPage(name: Nav.serviceProviderSignupWelcomeScreen, page: () =>  SignupWelcomeScreen()),
      GetPage(name: Nav.selectServiceScreen, page: () =>  const SelectServiceScreen())
    ],
    debugShowCheckedModeBanner: false,
  ));
}
