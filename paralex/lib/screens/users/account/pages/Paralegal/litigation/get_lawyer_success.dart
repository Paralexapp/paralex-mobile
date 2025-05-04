import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';

import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import '../../../../../../service_provider/controllers/user_choice_controller.dart';
import '../../../../../../service_provider/view/widgets/custom_button.dart';

final userChoiceController = Get.find<UserChoiceController>();
class GetLawyerSuccess extends StatelessWidget {
  final String? message;
  const GetLawyerSuccess({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                color: PaintColors.paralexpurple,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                  child: Image.asset(
                "assets/images/high-five.png",
                fit: BoxFit.cover,
              )),
            ),
            const SizedBox(height: 10),
            Text(
              "Congratulations!",
              style: FontStyles.headingText.copyWith(color: Colors.black),
            ),
            Text(
              message ?? "Your submission was successful. The Lawyer will reach out to you via mail soon when they accept your request.",
              style: FontStyles.smallCapsIntro
                  .copyWith(color: Colors.black, letterSpacing: 0, fontSize: 14),
            ),
            const SizedBox(height: 40),
            CustomButton(
                desiredWidth: 70,
                buttonText: "Go back to home ",
                buttonColor: PaintColors.paralexpurple,
                ontap: () {
                  if (userChoiceController.isUser.value) {
                    Get.offNamed(Nav.home);
                  } else {
                    Get.offNamed(Nav.lawyerDashboard);
                  }
                },
            )
          ],
        ),
      ),
    );
  }
}
