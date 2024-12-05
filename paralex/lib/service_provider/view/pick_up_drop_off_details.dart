import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';
import '../../routes/navs.dart';
import '../controllers/package_feedback_controller.dart';

class PickUpDropOffDetails extends StatelessWidget {
  final pointName = Get.arguments;
   PickUpDropOffDetails({super.key});

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
          pointName,
          style: FontStyles.smallCapsIntro.copyWith(
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000)),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$pointName 2 packages",
              style: FontStyles.headingText.copyWith(
                color: PaintColors.paralexpurple,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 15),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Take Videos To Complete",
                    style: FontStyles.smallCapsIntro.copyWith(
                        letterSpacing: 0,
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            PackageDetailWithStatusIcon()
          ],
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
                buttonText: pointName,
                buttonColor: PaintColors.paralexpurple,
                ontap: () {
                  if (pointName == "Drop-off") {
                    Get.toNamed(Nav.dropoffConfirmation);
                  } else {
                    Get.toNamed(Nav.rating);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PackageDetailWithStatusIcon extends StatelessWidget {
  const PackageDetailWithStatusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final PackageController controller = Get.put(PackageController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Package 1",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            SizedBox(width: 5),
            Obx(() => Icon(
              controller.isVideoTaken.value
                  ? Icons.check_circle
                  : Icons.cancel,
              color: controller.isVideoTaken.value ? Colors.green : Colors.red,
            )),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "Detail: 20 X 16 X 10 (Inch),32lbs",
          style: TextStyle(
            letterSpacing: 0,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Type: Electronic devices",
          style: TextStyle(
            letterSpacing: 0,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 10),
        Obx(() {
          if (controller.isVideoTaken.value) {
            // Display the video thumbnail and duration
            return Stack(
              children: [
                // Thumbnail
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(File(controller.videoThumbnailPath.value)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Video Duration
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controller.videoDuration.value,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Display the "Take a video" container
            return GestureDetector(
              onTap: () => controller.takeVideo(),
              child: DottedBorder(
                color: PaintColors.paralexpurple,
                strokeWidth: 2,
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                dashPattern: [6, 4],
                child: Container(
                  height: 100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_sharp,
                          color: PaintColors.paralexpurple,
                        ),
                        Text(
                          "Take a video",
                          style: TextStyle(color: PaintColors.paralexpurple, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        }),
      ],
    );
  }
}



