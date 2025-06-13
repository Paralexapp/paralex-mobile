import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/paralegal/lawyer_dashboard.dart';
import 'package:paralex/paralegal/lawyer_profile.dart';
import 'package:paralex/paralegal/request_lawyer_form.dart';
import 'package:paralex/screens/users/account/pages/Logistics/logistics_chat.dart';
import 'package:paralex/screens/users/account/pages/Logistics/logistics_delivery_info.dart';
import 'package:paralex/screens/users/account/pages/Logistics/logistics_parcel_delivered.dart';
import 'package:paralex/screens/users/account/pages/Logistics/logistics_parcel_tracking.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/screens/splash/splash.dart';
import 'package:paralex/screens/users/account/home.dart';
import 'package:paralex/screens/users/account/pages/Logistics/rider_accept_success.dart';
import 'package:paralex/screens/users/account/pages/Logistics/user_request_delivery_success.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/Legal/cac.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/Legal/immigration.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/Legal/legal_assistance.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/Legal/nafdac.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/Legal/trademark.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/bond/bond_step_1.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/bond/bond_step_2.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/bond/bond_step_3.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/bond/bond_step_4.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/bond/bond_step_5.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/bond/bond_success.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/lawyer_paralegal_home.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/litigation/get_lawyer_success.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/nafdac_steps.dart/cac_step_one.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/nafdac_steps.dart/cac_step_two.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/nafdac_steps.dart/immigration_step_one.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/nafdac_steps.dart/immigration_step_two.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/nafdac_steps.dart/nafdac_step_one.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/nafdac_steps.dart/nafdac_step_two.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/nafdac_steps.dart/trademark_step_one.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/nafdac_steps.dart/trademark_step_two.dart';
import 'package:paralex/screens/users/account/pages/Paralegal/paralegal_home.dart';
import 'package:paralex/screens/users/account/pages/lawyer/lawyer_home.dart';
import 'package:paralex/screens/users/auth_process/final_step.dart';
import 'package:paralex/screens/users/auth_process/login.dart';
import 'package:paralex/screens/users/auth_process/registration.dart';
import 'package:paralex/screens/users/auth_process/otp.dart';
import 'package:paralex/screens/users/auth_process/rest_process/step_one.dart';
import 'package:paralex/screens/users/auth_process/rest_process/step_three.dart';
import 'package:paralex/screens/users/auth_process/rest_process/step_two.dart';
import 'package:paralex/screens/users/auth_process/tellus_more.dart';
import 'package:paralex/screens/users/auth_process/verification_message.dart';
import 'package:paralex/screens/welcomeslides/last_welcome_screen.dart';
import 'package:paralex/screens/welcomeslides/welcome.dart';
import 'package:paralex/service_provider/controllers/notification_controller.dart';
import 'package:paralex/service_provider/controllers/user_choice_controller.dart';
import 'package:paralex/service_provider/view/about_you/about_you.dart';
import 'package:paralex/service_provider/view/about_you/about_you_contd.dart';
import 'package:paralex/service_provider/view/about_you/about_you_for_lawyers.dart';
import 'package:paralex/service_provider/view/bank_info.dart';
import 'package:paralex/service_provider/view/delivery_info.dart';
import 'package:paralex/service_provider/view/delivery_info1.dart';
import 'package:paralex/service_provider/view/delivery_info2.dart';
import 'package:paralex/service_provider/view/departure_detail.dart';
import 'package:paralex/service_provider/view/destination_detail.dart';
import 'package:paralex/service_provider/view/dropoff_confirmation.dart';
import 'package:paralex/service_provider/view/earning.dart';
import 'package:paralex/service_provider/view/guarantor_detail.dart';
import 'package:paralex/service_provider/view/order_detail.dart';
import 'package:paralex/service_provider/view/pick_up_drop_off.dart';
import 'package:paralex/service_provider/view/pick_up_drop_off_details.dart';
import 'package:paralex/service_provider/view/profile.dart';
import 'package:paralex/service_provider/view/rating.dart';
import 'package:paralex/service_provider/view/schedule_list.dart';
import 'package:paralex/service_provider/view/setup_schedule.dart';
import 'package:paralex/service_provider/view/signup_screens/select_service_screen.dart';
import 'package:paralex/service_provider/view/signup_screens/signup_welcome_screen.dart';
import 'package:paralex/service_provider/view/update_service_for_lawyer.dart';
import 'news/detailed_news_screen.dart';
import 'news/news_screen.dart';
import 'screens/users/account/pages/Logistics/logistics_call.dart';
import 'screens/users/account/pages/Logistics/logistics_find_delivery.dart';
import 'screens/users/account/pages/Logistics/logistics_home.dart';
import 'screens/users/account/pages/Logistics/logistics_payment_method.dart';
import 'screens/users/account/pages/Logistics/logistics_payment_method2.dart';
import 'screens/users/account/pages/Logistics/logistics_payment_method3.dart';

Future<void> main() async {
  // Get.put(UserChoiceController());
  // Get.put<NotificationsController>(NotificationsController());

  Get.put(UserChoiceController(), permanent: true);
  Get.put<NotificationsController>(NotificationsController(), permanent: true);

  runApp(GetMaterialApp(
    initialRoute: Nav.splash,
    getPages: [
      GetPage(name: Nav.splash, page: () => const SplashScreen()),
      GetPage(name: Nav.welcomeShow, page: () => const WelcomeSliders()),
      GetPage(name: Nav.lastWelcomeScreen, page: () => const LastWelcomeScreen()),
      // GetPage(
      //     name: Nav.serviceProviderSignupWelcomeScreen,
      //     page: () => SignupWelcomeScreen()),
      GetPage(name: Nav.selectServiceScreen, page: () => const SelectServiceScreen()),
      GetPage(
          name: Nav.serviceProviderSignupWelcomeScreen,
          page: () => SignupWelcomeScreen()),
      GetPage(name: Nav.selectServiceScreen, page: () => const SelectServiceScreen()),
      GetPage(name: Nav.userSignupScreen, page: () => const UserRegistration()),
      GetPage(name: Nav.otpScreen, page: () => const OtpVerification()),
      GetPage(name: Nav.verificationScreen, page: () => const VerificationMessage()),
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
      GetPage(name: Nav.bondStepA, page: () => BondFirstStep()),
      GetPage(name: Nav.bondStepB, page: () => BondSecondStep()),
      GetPage(name: Nav.bondStepC, page: () => BondThirdStep()),
      GetPage(name: Nav.bondStepD, page: () => BondFourthStep()),
      GetPage(name: Nav.bondStepE, page: () => BondStepFive()),
      GetPage(name: Nav.bondSubmitted, page: () => const BondSuccess()),
      GetPage(name: Nav.getLawyerSubmitted, page: () => const GetLawyerSuccess()),
      GetPage(name: Nav.deliveryAccepted, page: () => const RiderAcceptSuccess()),
      GetPage(name: Nav.deliveryRequestSuccess, page: () => const UserRequestDeliverySuccess()),
      GetPage(name: Nav.legalServiceHome, page: () => const LegalAssistance()),
      GetPage(name: Nav.nafdacReg, page: () => const NafdacRegistration()),
      GetPage(name: Nav.cacReg, page: () => const CacRegistration()),
      GetPage(name: Nav.trademarkReg, page: () => const TrademarkRegistration()),
      GetPage(name: Nav.immigrationReg, page: () => const ImmigrationRegistration()),
      GetPage(name: Nav.nafdacStepOne, page: () => const NafdacStepOne()),
      GetPage(name: Nav.nafdacStepTwo, page: () => const NafdacStepTwo()),
      GetPage(name: Nav.cacStepOne, page: () => const CacStepOne()),
      GetPage(name: Nav.cacStepTwo, page: () => const CacStepTwo()),
      GetPage(name: Nav.immigrationStepOne, page: () => const ImmigrationStepOne()),
      GetPage(name: Nav.immigrationStepTwo, page: () => const ImmigrationStepTwo()),
      GetPage(name: Nav.trademarkStepOne, page: () => const TrademarkStepOne()),
      GetPage(name: Nav.trademarkStepTwo, page: () => const TradeMarkStepTwo()),
      GetPage(name: Nav.bankInfo, page: () => BankInfo()),
      //GetPage(name: Nav.notification, page: () => DeliveryNotification()),
      GetPage(name: Nav.findAlawyer, page: () => const LawyerHome()),
      GetPage(name: Nav.deliveryInfo, page: () => DeliveryInfo()),
      GetPage(name: Nav.logisticsDeliveryInfo, page: () => LogisticsDeliveryInfo()),
      GetPage(name: Nav.logisticsHome, page: () => LogisticsHome()),
      GetPage(name: Nav.logisticsFindDelivery, page: () => LogisticsFindDelivery()),
      GetPage(name: Nav.logisticsPaymentMethod, page: () => LogisticsPaymentMethod()),
      GetPage(name: Nav.logisticsPaymentMethod2, page: () => LogisticsPaymentMethod2()),
      GetPage(name: Nav.logisticsPaymentMethod3, page: () => LogisticsPaymentMethod3()),
      GetPage(name: Nav.logisticsParcelDelivered, page: () => LogisticsParcelDelivered()),
      GetPage(name: Nav.logisticsParcelTracking, page: () => LogisticsParcelTracking()),
      GetPage(name: Nav.logisticsCall, page: () => LogisticsCall()),
      GetPage(name: Nav.logisticsChat, page: () => LogisticsChat()),
      GetPage(name: Nav.requestLawyer, page: () => RequestLawyerForm()),
      GetPage(name: Nav.lawyerProfile, page: () => LawyerProfile()),
      GetPage(name: Nav.destinationDetail, page: () => DestinationDetail()),
      GetPage(name: Nav.departureDetail, page: () => DepartureDetail()),
      GetPage(name: Nav.schedule, page: () => SetupSchedule()),
      GetPage(name: Nav.deliveryInfo1, page: () => DeliveryInfo1()),
      GetPage(name: Nav.scheduleList, page: () => ScheduleList()),
      GetPage(name: Nav.deliveryInfo2, page: () => DeliveryInfo2()),
      GetPage(name: Nav.pickUp, page: () => PickUpDropOff()),
      GetPage(name: Nav.pickUpDetail, page: () => PickUpDropOffDetails()),
      GetPage(name: Nav.dropoffConfirmation, page: () => DropoffConfirmation()),
      GetPage(name: Nav.rating, page: () => Rating()),
      GetPage(name: Nav.earning, page: () => Earning()),
      GetPage(name: Nav.profile, page: () => Profile()),
      GetPage(name: Nav.orderDetail, page: () => OrderDetail()),
      GetPage(name: Nav.updateLawyerData, page: () => UpdateServiceForLawyer()),
      GetPage(name: Nav.aboutYouForLawyer, page: () => AboutYouForLawyers()),
      GetPage(name: Nav.lawyerDashboard, page: () => LawyerDashboard()),
      GetPage(name: Nav.newsScreen, page: () => NewsScreen()),
      GetPage(name: Nav.detailedNewsScreen, page: () => DetailedNewsScreen()),
      //GetPage(name: Nav.notificationDetail, page: () => NotificationDetailScreen()),
      GetPage(name: Nav.lawyerParalegalHome, page: () => LawyerParalegalDashboard()),
    ],
    debugShowCheckedModeBanner: false,
  ));
}
