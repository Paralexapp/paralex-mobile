import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/back_button.dart';
import '../../../reusables/fonts.dart';
import '../../../reusables/paints.dart';
import '../../../routes/navs.dart';
import '../../controllers/select_service_controller.dart';
import '../../controllers/user_choice_controller.dart';
import '../widgets/select_service_widget.dart';

class SelectServiceScreen extends StatelessWidget {
  const SelectServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userChoiceController = Get.find<UserChoiceController>();
    final SelectServiceController controller =
        Get.put(SelectServiceController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
        leading: IconButton(
            onPressed: () => Get.back(), icon: PinkButton.backButton),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose your \n Role",
              style: FontStyles.headingText.copyWith(
                  color: PaintColors.paralexpurple,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.selectedButtonIndex(0);
                        userChoiceController.selectServiceProviderLawyer();
                      },
                      child: SelectServiceWidget(
                        imgPath: "assets/images/mace.svg",
                        firstText: "Lawyer",
                        secondText: "Sign Up",
                        thirdText: "as Lawyer",
                        bckgColor: controller.getButtonColor(0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Obx(
                  () => Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.selectedButtonIndex(1);
                        userChoiceController.selectServiceProviderRider();
                      },
                      child: SelectServiceWidget(
                        imgPath: "assets/images/truck.svg",
                        firstText: "Delivery Agent",
                        secondText: "Sign Up",
                        thirdText: "as Delivery Agent",
                        bckgColor: controller.getButtonColor(1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: size.width * 0.9,
              decoration: const BoxDecoration(
                color: PaintColors.paralexpurple,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                onTap: () {
                  if (controller.selectedButtonIndex == 0) {
                    Get.toNamed(Nav.serviceProviderSignupWelcomeScreen);
                  } else if (controller.selectedButtonIndex == 1) {
                    Get.toNamed(Nav.serviceProviderSignupWelcomeScreen);
                  }
                },
                child: Center(
                  child: Text(
                    "CONTINUE",
                    style: FontStyles.smallCapsIntro.copyWith(
                      color: Colors.white,
                      letterSpacing: 0,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
