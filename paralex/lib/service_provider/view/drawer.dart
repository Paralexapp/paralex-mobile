import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../reusables/paints.dart';
import 'package:get/get.dart';

import '../../routes/navs.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
               //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: PaintColors.paralexpurple),
                  child: SvgPicture.asset(
                    "assets/images/blue_blank_human_image.svg",
                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
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
                    SizedBox(height: 10),
                    const Text(
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
          ListTile(
            leading: const Icon(Icons.star_border_outlined),
            title: const Text("Update service"),
            onTap: () {
              Get.toNamed(Nav.updateLawyerData);
            },
          ),
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
      ),
    );
  }
}
