import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/screens/users/account/pages/logistics/home.dart';
import 'package:paralex/screens/users/account/pages/controllers/home_controller.dart';
import 'package:paralex/screens/users/account/pages/dashboard.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      body: PageView(
        controller: controller.pageController,
        physics: const BouncingScrollPhysics(),
        children: const [Dashboard(), ParalegalHome()],
      ),
      bottomNavigationBar: BottomAppBar(
        color: PaintColors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomNav(context, icon: Iconsax.home_2, page: 0, label: "Home"),
              _bottomNav(context,
                  icon: Iconsax.archive_book, page: 1, label: "News"),
              _bottomNav(context,
                  icon: Iconsax.user_square, page: 2, label: "Search"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomNav(BuildContext context,
      {required icon, required page, required label}) {
    //Add zoom tap animation
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        Text(label)
      ],
    );
  }
}
