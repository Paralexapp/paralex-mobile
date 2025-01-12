import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/news/news_screen.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/screens/users/account/pages/logistics/home.dart';
import 'package:paralex/screens/users/account/pages/controllers/home_controller.dart';
import 'package:paralex/screens/users/account/pages/dashboard.dart';

import '../../../service_provider/view/search_tab.dart';

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
          onPageChanged: (index) {
            controller.currentPage.value = index;
          },
          children:  [
            Dashboard(),
            NewsScreen(),
            SearchTab(),
          ],
        ),
      bottomNavigationBar: BottomAppBar(
        color: PaintColors.white,
        child: Obx(() {
          final HomeController controller = Get.find<HomeController>();
          final int currentPage = controller.currentPage.value;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomNav(
                  context,
                  icon: Iconsax.home_2,
                  page: 0,
                  label: "Home",
                  currentPage: currentPage,
                  onTap: () => controller.goToTab(0),
                ),
                _bottomNav(
                  context,
                  icon: Iconsax.archive_book,
                  page: 1,
                  label: "News",
                  currentPage: currentPage,
                  onTap: () => controller.goToTab(1),
                ),
                _bottomNav(
                  context,
                  icon: Iconsax.user_square,
                  page: 2,
                  label: "Search",
                  currentPage: currentPage,
                  onTap: () => controller.goToTab(2),
                ),
              ],
            ),
          );
        }),
      ),

    );
  }

  Widget _bottomNav(BuildContext context,
      {required IconData icon,
        required int page,
        required String label,
        required int currentPage,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: currentPage == page ? PaintColors.paralexpurple : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: currentPage == page ? PaintColors.paralexpurple : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }


}
