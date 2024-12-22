import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../reusables/paints.dart';
import '../../routes/navs.dart';
import 'package:paralex/service_provider/controllers/signup_controller.dart';
import '../controllers/user_choice_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch the UserChoiceController
    final userChoiceController = Get.find<UserChoiceController>();

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
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Nav.profile);
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: PaintColors.paralexpurple),
                    child: SvgPicture.asset(
                      "assets/images/blue_blank_human_image.svg",
                      colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome back,",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Joseph",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                ListTile(
                  leading: const Icon(Icons.star_border_outlined),
                  title: const Text("Update service"),
                  onTap: () {
                    Get.toNamed(Nav.updateLawyerData);
                  },
                ),
                ],
                if (userChoiceController.selectedUserType.value !=
                    UserType.SERVICE_PROVIDER_LAWYER) ...[
                  ListTile(
                    leading: const Icon(Icons.update_outlined),
                    title: const Text("Recent Orders"),
                    onTap: () {},
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
                  leading: const Icon(Icons.notifications_outlined),
                  title: const Text("Notifications"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.inbox),
                  title: const Text("Inbox"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text("Account Settings"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline_outlined),
                  title: const Text("Help & feedback"),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    "Log out",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {},
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
