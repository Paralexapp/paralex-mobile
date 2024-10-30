import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/back_button.dart';
import 'package:paralax/service_provider/view/signup_screens/widgets/select_service_widget.dart';

import '../../../reusables/fonts.dart';
import '../../../reusables/paints.dart';
import '../../controllers/select_service_controller.dart';

class SelectServiceScreen extends StatelessWidget {
  const SelectServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectServiceController controller = Get.put(SelectServiceController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
        leading: IconButton(
            onPressed: () => Get.back(), icon: PinkButton.backButton),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 25,bottom: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose your \n preferred",
              style: FontStyles.headingText.copyWith(
                  color: PaintColors.paralaxpurple,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => InkWell(
                  onTap: () => controller.selectedButtonIndex(0),
                  child: SelectServiceWidget(
                      imgPath: "assets/images/mace.svg",
                      firstText: "Lawyer",
                      secondText: "I provide legal",
                      thirdText: "services to clients",
                      bckgColor: controller.getButtonColor(0),
                  ),
                ),
                ),
                const SizedBox(width: 30),
                Obx(() => InkWell(
                  onTap: () => controller.selectedButtonIndex(1),
                  child: SelectServiceWidget(
                      imgPath: "assets/images/truck.svg",
                      firstText: "Delivery Agent",
                      secondText: "I provide legal",
                      thirdText: "delivery services",
                      bckgColor: controller.getButtonColor(1),
                  ),
                ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: size.width * 0.9,
              decoration: const BoxDecoration(
                color:  PaintColors.paralaxpurple,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                onTap: () {},
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
