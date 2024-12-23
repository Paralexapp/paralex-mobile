import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/custom_text_field.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';
import '../../routes/navs.dart';

class DropoffConfirmation extends StatelessWidget {
  const DropoffConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
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
          "Confirm Delivery",
          style: FontStyles.smallCapsIntro.copyWith(
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000)),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Text(
                "After filling, users receive a proof of delivery (POD) and invoice/receipt if applicable. Drivers provide copies of these documents along with any return labels.",
                style: FontStyles.smallCapsIntro.copyWith(
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF797979),
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: PaintColors.paralexpurple),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recipient's Name",
                      style: FontStyles.smallCapsIntro.copyWith(
                          fontSize: 16,
                          letterSpacing: 0,
                          color: Color(0xFF000000)),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      hintText: "Recipient's name",
                      prefix: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          "assets/images/icons_calender.svg",
                          width: 17,
                          height: 17,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delivery date",
                                style: FontStyles.smallCapsIntro.copyWith(
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    color: Color(0xFF000000)),
                              ),
                              SizedBox(height: 5),
                              CustomTextField(
                                hintText: "Delivery date",
                                prefix: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                      "assets/images/bx_trip.svg"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delivery Time",
                                style: FontStyles.smallCapsIntro.copyWith(
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    color: Color(0xFF000000)),
                              ),
                              SizedBox(height: 5),
                              CustomTextField(
                                hintText: "Delivery time",
                                prefix: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                      "assets/images/bx_trip.svg"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Confirmation Number",
                      style: FontStyles.smallCapsIntro.copyWith(
                          fontSize: 16,
                          letterSpacing: 0,
                          color: Color(0xFF000000)),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      hintText: "Confirmation number",
                      prefix: Padding(
                        padding: const EdgeInsets.all(
                            10.0), // Reduce padding if needed
                        child: SvgPicture.asset(
                            "assets/images/tdesign_location.svg"),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Invoice or Receipt",
                      style: FontStyles.smallCapsIntro.copyWith(
                          fontSize: 16,
                          letterSpacing: 0,
                          color: Color(0xFF000000)),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      hintText: "Upload Invoice or Receipt",
                      prefix: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset(
                            "assets/images/solar_delivery_broken.svg"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: CustomButton(
                desiredWidth: 0.9,
                buttonText: "Submit",
                buttonColor: PaintColors.paralexpurple,
                ontap: (){Get.toNamed(Nav.rating);},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
