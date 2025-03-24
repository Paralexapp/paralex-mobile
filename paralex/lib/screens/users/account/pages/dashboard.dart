import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import 'package:badges/badges.dart' as badges;
import '../../../../service_provider/controllers/notification_controller.dart';
import '../../../../service_provider/controllers/user_choice_controller.dart';
import '../../../../service_provider/view/delivery_notification.dart';

final userController = Get.find<UserChoiceController>();
final NotificationsController controller = Get.find();

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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

    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures icons are spaced out evenly
                  crossAxisAlignment: CrossAxisAlignment.center,  // Vertically aligns the icons in the middle
                  children: [
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

                    // Wrap the icons in a Row to align them properly
                    Row(
                      mainAxisSize: MainAxisSize.min, // Ensures the row doesn't take up extra space
                      children: [
                        Obx(() {
                          int unreadCount = controller.unreadCount.value;

                          return badges.Badge(
                            position: badges.BadgePosition.topEnd(top: -10, end: -10),
                            showBadge: unreadCount > 0,
                            badgeContent: Text(
                              unreadCount.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: Colors.red,
                              shape: badges.BadgeShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DeliveryNotification(
                                      appBarTitle: "Notification",
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Iconsax.notification,
                                color: PaintColors.paralexpurple,
                                size: 30,
                              ),
                            ),
                          );
                        }),
                        IconButton(
                          icon: const Icon(Icons.exit_to_app, color: PaintColors.paralexpurple),
                          onPressed: () {
                            // Perform the logout action and navigate to the logout screen
                            _logoutUser();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )

          ),
          // Main widgets and elements follow
          Padding(
            padding: const EdgeInsets.all(25),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Nav.logisticsDeliveryInfo);
              },
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.12),
                width: size.width * 0.9,
                height: 100,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/paralegal.png'),
                  ),
                  borderRadius: BorderRadius.circular(16), // Optional: Rounded corners
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: GestureDetector(
              onTap: () => Get.toNamed(Nav.paralegalHome),
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.22),
                width: size.width,
                height: 150,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/log2.png'),
                  ),
                  borderRadius: BorderRadius.circular(16), // Optional: Rounded corners
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.48),
              width: size.width,
              height: 100,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.purple,
                    PaintColors.paralexpurple,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20), // Optional: Rounded corners
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.40),
            child: Image.asset("assets/images/law.png"),
          ),
          Positioned(
            right: 70,
            child: GestureDetector(
              onTap: () => Get.toNamed(Nav.findAlawyer),
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Need Legal Service?",
                      style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.white,
                        letterSpacing: 0,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Hire a Lawyer",
                          style: FontStyles.headingText.copyWith(fontSize: 22),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 45,
                          width: 45,
                          decoration: const BoxDecoration(
                            color: PaintColors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                            child: Icon(Iconsax.arrow_right_2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.58),
              width: size.width,
              height: 50,
              decoration: const BoxDecoration(
                color: PaintColors.bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.60),
                width: size.width * 0.9,
                height: 100,
                decoration: BoxDecoration(
                  color: PaintColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          // Image.asset(
                          //   "assets/images/law.png",
                          //   height: 40,
                          // ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("No Activity Yet!"),
                              // Text("SEPTEMBER 16 . 8:00AM"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                  ),
                                  // Text("Submitted"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logoutUser() async {
    // Handle logout logic here, like clearing session or token
userController.clearSession();
    // Navigate to the logout route or login screen
    Get.offAllNamed(Nav.login);  // Adjust the route according to your app's flow
  }
}
