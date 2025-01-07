import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import '../reusables/fonts.dart';
import '../reusables/paints.dart';
import '../routes/navs.dart';
import '../../../../service_provider/controllers/user_choice_controller.dart';
import '../service_provider/view/drawer.dart';
import '../reusables/bottom_nav.dart'; // Import for the bottom navigation bar

final userController = Get.find<UserChoiceController>();

class LawyerDashboard extends StatefulWidget {
  const LawyerDashboard({super.key});

  @override
  State<LawyerDashboard> createState() => _LawyerDashboardState();
}

class _LawyerDashboardState extends State<LawyerDashboard> {
  int _currentIndex = 0; // Index to track the current selected tab

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
      drawer: const MyDrawer(), // Add drawer
      body: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      // Header Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: Icon(
                              Icons.menu,
                              color: PaintColors.paralexpurple,
                              size: 30,
                            ),
                          ),
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
                          const Icon(
                            Iconsax.notification,
                            color: PaintColors.paralexpurple,
                            size: 30,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      // Paralegal Image Section
                      InkWell(
                        onTap: () {
                          Get.toNamed(Nav.logisticsDeliveryInfo);
                        },
                        child: Container(
                          width: size.width * 0.9,
                          height: 100,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/paralegal.png'),
                              fit: BoxFit.contain,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      // Logistics Image Section
                      GestureDetector(
                        onTap: () => Get.toNamed(Nav.lawyerParalegalHome),
                        child: Container(
                          width: size.width * 0.9,
                          height: 150,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/log2.png'),
                              fit: BoxFit.contain,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      // SizedBox(height: size.height * 0.03),
                      // Delivery Details Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: PaintColors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/law.png",
                              height: 40,
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Delivery to Ikoyi Supreme court",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text("DECEMBER 31 . 8:00AM"),
                                SizedBox(height: 8),
                                Text(
                                  "Submitted",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
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
        },
      ),
    );
  }
}
