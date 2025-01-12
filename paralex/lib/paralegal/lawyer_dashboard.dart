import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import '../reusables/fonts.dart';
import '../reusables/paints.dart';
import '../routes/navs.dart';
import '../../../../service_provider/controllers/user_choice_controller.dart';
import '../service_provider/controllers/notification_controller.dart';
import '../service_provider/view/delivery_notification.dart';
import '../service_provider/view/drawer.dart';
import '../reusables/bottom_nav.dart'; // Import for the bottom navigation bar
import '../news/news_screen.dart';
import '../../../../service_provider/view/search_tab.dart';
import 'package:badges/badges.dart' as badges;

final userController = Get.find<UserChoiceController>();
final NotificationsController controller = Get.put(NotificationsController());
final NotificationsController inboxController = Get.put(NotificationsController());

class LawyerDashboard extends StatefulWidget {
  const LawyerDashboard({super.key});

  @override
  State<LawyerDashboard> createState() => _LawyerDashboardState();
}

class _LawyerDashboardState extends State<LawyerDashboard> {
  int _currentIndex = 0; // Index to track the current selected tab
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);

    // Retrieve firstName and lastName from Get.arguments and set them in the userController
    final args = Get.arguments;
    if (args != null) {
      userController.firstName.value = args['firstName'] ?? '';
      userController.lastName.value = args['lastName'] ?? '';
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('EEEE, MMM d, y').format(now);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      drawer: const MyDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          _buildDashboard(context, formattedDate, size),
          NewsScreen(),
          SearchTab(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDashboard(
      BuildContext context, String formattedDate, Size size) {
    return Builder(
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                _buildHeader(context, formattedDate),
                SizedBox(height: size.height * 0.03),
                _buildImageSection(context, size, 'assets/images/paralegal.png',
                    Nav.logisticsDeliveryInfo),
                SizedBox(height: size.height * 0.03),
                _buildImageSection(context, size, 'assets/images/log2.png',
                    Nav.lawyerParalegalHome),
                SizedBox(height: size.height * 0.03),
                _buildDeliveryDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String formattedDate) {
    return Row(
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
      ],
    );
  }

  Widget _buildImageSection(
      BuildContext context, Size size, String imagePath, String routeName) {
    return InkWell(
      onTap: () => Get.toNamed(routeName),
      child: Container(
        width: size.width * 0.9,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildDeliveryDetails() {
    return Container(
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
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
