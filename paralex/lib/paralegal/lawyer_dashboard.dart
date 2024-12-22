import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../reusables/fonts.dart';
import '../reusables/paints.dart';
import '../routes/navs.dart';
import '../service_provider/controllers/user_choice_controller.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../service_provider/view/drawer.dart'; // Import your MyDrawer widget

final userController = Get.find<UserChoiceController>();

class LawyerDashboard extends StatefulWidget {
  const LawyerDashboard({super.key});

  @override
  State<LawyerDashboard> createState() => _LawyerDashboardState();
}

class _LawyerDashboardState extends State<LawyerDashboard> {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now(); // Get current date and time
    final String formattedDate = DateFormat('EEEE, MMM d, y').format(now);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      // Assign the drawer
      drawer: const MyDrawer(),
      body: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(25.0),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    // Wrap the menu icon in a GestureDetector to open the drawer
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        color: PaintColors.paralexpurple,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          style: FontStyles.smallCapsIntro.copyWith(
                            color: PaintColors.paralexpurple,
                            fontSize: 14,
                            letterSpacing: 0,
                          ),
                        ),
                        Obx(() => Text(
                          "Hello, ${userController.lastName.value} ${userController.firstName.value}",
                          style: FontStyles.headingText.copyWith(
                            color: PaintColors.paralexpurple,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        )),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Iconsax.sms,
                      color: PaintColors.paralexpurple,
                      size: 30,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Nav.logisticsDeliveryInfo);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.04),
                    width: size.width * 0.9,
                    height: 100,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/paralegal.png'),
                      ),
                      borderRadius: BorderRadius.circular(
                          16), // Optional: Rounded corners
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
