import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/custom_text_field.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';
import '../../routes/navs.dart';

class DepartureDetail extends StatelessWidget {
  const DepartureDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PaintColors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF222B45),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Detail",
          style: FontStyles.smallCapsIntro.copyWith(
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
              "When do you depart?",
              style: FontStyles.headingText.copyWith(
                  color: Color(0xFF000000),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            CustomTextField(
              hintText: "Choose schedule",
              suffixIcon: Icon(
                Icons.event_available,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            CustomButton (
                desiredWidth: 0.9,
                buttonText: "Next",
                buttonColor: PaintColors.paralexpurple,
                ontap: (){
                  Get.toNamed(Nav.schedule);
                }),
          ],
        ),
      ),
    );
  }
}
