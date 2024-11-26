import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';
import '../../routes/navs.dart';

void showWellDonePopup(BuildContext context) {
  var size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        contentPadding: EdgeInsets.all(16.0),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Makes dialog compact
          children: [
            SvgPicture.asset("assets/images/designed_check.svg"),
            SizedBox(height: 16.0),
            Text(
              "Well Done!",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "We will notify you orders before schedule",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 24.0),
            CustomButton(
                desiredWidth: 0.85,
                buttonText: "Done",
                buttonColor: PaintColors.paralexpurple,
                ontap:(){
                  Get.toNamed(Nav.deliveryInfo1);
                })
          ],
        ),
      );
    },
  );
}

class SetupSchedule extends StatelessWidget {
  const SetupSchedule({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Great! Let's set up your\nupcoming trip",
              style: FontStyles.headingText.copyWith(
                  color: Color(0xFF000000),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Center(
                child: Image(
                    image:
                        AssetImage("assets/images/navigation_on_phone.png"))),
            Spacer(),
            CustomButton(
                desiredWidth: 0.9,
                buttonText: "Set Up Schedule",
                buttonColor: PaintColors.paralexpurple,
                ontap: () => showWellDonePopup(context)),
          ],
        ),
      ),
    );
  }
}
