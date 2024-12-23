import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../reusables/bottom_nav.dart';
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
  int _currentIndex = 0; // Track the active tab

  @override
  void initState() {
    super.initState();

    // Retrieve firstName and lastName from Get.arguments and set them in the userController
    final args = Get.arguments;
    if (args != null) {
      userController.firstName.value = args['firstName'] ?? '';
      userController.lastName.value = args['lastName'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now(); // Get current date and time
    final String formattedDate = DateFormat('EEEE, MMM d, y').format(now);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      drawer: const MyDrawer(),
      body: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(25.0),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
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
                          "Hello, ${userController.firstName.value} ${userController.lastName.value}",
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
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 200),
                    const Text(""),
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery to Ikoyi Supreme court"),
                    Text("SEPTEMBER 16 . 8:00AM"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 200),
                        Text("Submitted"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Optionally, navigate or perform actions based on index
        },
      ),
    );
  }
}
