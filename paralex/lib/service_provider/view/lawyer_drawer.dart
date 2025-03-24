import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../reusables/paints.dart';
import '../../routes/navs.dart';
import '../controllers/notification_controller.dart';
import '../../screens/users/account/pages/account_settings_page.dart';
import '../controllers/user_choice_controller.dart';
import 'delivery_notification.dart';
import 'package:badges/badges.dart' as badges;

final NotificationsController controller = Get.find();
final userChoiceController = Get.find<UserChoiceController>();


class MyLawyerDrawer extends StatelessWidget {
  const MyLawyerDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                // GestureDetector(
                //   onTap: () {
                //     Get.toNamed(Nav.profile);
                //   },
                //   child: Container(
                //     width: 70,
                //     height: 70,
                //     padding: const EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(50),
                //       color: PaintColors.paralexpurple,
                //     ),
                //     child: SvgPicture.asset(
                //       "assets/images/blue_blank_human_image.svg",
                //       colorFilter:
                //       const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome back,",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      final firstName = userChoiceController.firstName.value;
                      final lastName = userChoiceController.lastName.value;
                      return Text(
                        firstName.isEmpty && lastName.isEmpty
                            ? "User" // Fallback text
                            : "$firstName $lastName",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          Obx(() {
            // Show or hide tiles based on UserType
            return Column(
              children: [
                if (userChoiceController.selectedUserType.value !=
                    UserType.SERVICE_PROVIDER_RIDER) ...[
                  // ListTile(
                  //   leading: const Icon(Icons.star_border_outlined),
                  //   title: const Text("Update service"),
                  //   onTap: () {
                  //     Get.toNamed(Nav.updateLawyerData);
                  //   },
                  // ),
                ],
                if (userChoiceController.selectedUserType.value !=
                    UserType.SERVICE_PROVIDER_LAWYER) ...[
                  ListTile(
                    leading: const Icon(Icons.update_outlined),
                    title: const Text("Recent Orders"),
                    onTap: () {
                      Get.toNamed(Nav.earning);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.monetization_on_outlined),
                    title: const Text("Earnings"),
                    onTap: () {
                      Get.toNamed(Nav.earning);
                    },
                  ),
                ],
                ListTile(
                  leading: Obx(() {
                    int unreadCount = controller.unreadCount.value;

                    return badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -5, end: -5),
                      showBadge: unreadCount > 0,
                      badgeContent: Text(
                        unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Colors.red,
                        shape: badges.BadgeShape.circle,
                      ),
                      child: const Icon(Icons.notifications_outlined),
                    );
                  }),
                  title: const Text("Notifications"),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DeliveryNotification(
                          appBarTitle: "Notification",
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Obx(() {
                    int unreadCount = controller.inboxUnreadCount.value;

                    return badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -5, end: -5),
                      showBadge: unreadCount > 0,
                      badgeContent: Text(
                        unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Colors.red,
                        shape: badges.BadgeShape.circle,
                      ),
                      child: const Icon(Icons.inbox),
                    );
                  }),
                  title: const Text("Inbox"),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DeliveryNotification(
                          appBarTitle: "Message",
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text("Account Settings"),
                  onTap: () {
                    Get.to(() => const AccountSettingsPage());
                  },
                ),
                // ListTile(
                //   leading: const Icon(Icons.help_outline_outlined),
                //   title: const Text("Help & feedback"),
                //   onTap: () {},
                // ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    "Log out",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    userChoiceController.clearSession(); // Call the clearSession method to reset the session
                    Get.toNamed(Nav.login); // Navigate to the login screen
                  },
                ),

              ],
            );
          }),
        ],
      ),
    );
  }
}