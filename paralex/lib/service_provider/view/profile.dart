import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/service_provider/controllers/user_choice_controller.dart';
import 'dart:math'; // For random color generation
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';
import '../../screens/users/account/pages/account_settings_page.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
      appBar: AppBar(
        backgroundColor: PaintColors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.close,
              size: 20,
              color: Colors.grey,
            )),
        centerTitle: true,
        title: Text(
          "Profile",
          style: FontStyles.smallCapsIntro.copyWith(
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const AccountSettingsPage());
              },
              icon: Icon(
                Icons.mode_edit,
                color: Colors.black,
                size: 20,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: PaintColors.paralexpurple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFFE4E9F2)),
                    child: SvgPicture.asset(
                      "assets/images/blue_blank_human_image.svg",
                    ),
                  ),
                  // SizedBox(height: 15),
                  // Text(
                  //   "Joseph",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold),
                  // ),

                  SizedBox(height: 15),
                  Obx(() {
                    // Accessing the userName from the UserController
                    final userName = "${Get.find<UserChoiceController>().firstName.value} ${Get.find<UserChoiceController>().lastName.value}";

                    return Text(
                      userName,  // Use the dynamic user name here
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),

                ],
              ),
            ),
          ),
          Expanded(flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Overview",
                        style: TextStyle(
                            color: Color(0xFF404446),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OverviewCard(icon: Icons.star, quantity: "5.0", title: "Ratings"),
                        OverviewCard(icon: Icons.account_circle, quantity: "60%", title: "Satisfy"),
                        OverviewCard(icon: Icons.do_disturb_alt_sharp, quantity: "8%", title: "Cancel"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Review",
                        style: TextStyle(
                            color: Color(0xFF404446),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ReviewCard(name: "Nana Harley", review: "Good service", daysAgo: 5),
                          ReviewCard(name: "Alex Wall", review: "ok ok ok", daysAgo: 2),
                          ReviewCard(name: "Hugo King", review: "swift like lightning", daysAgo: 1),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Achievements",
                        style: TextStyle(
                            color: Color(0xFF404446),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 123,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFDFF9F7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/joy_icon.png",height: 44,width: 44,),
                            Text(
                              "Friendly Driver",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}

class OverviewCard extends StatelessWidget {
  const OverviewCard({super.key,required this.icon,required this.quantity,required this.title});

  final IconData icon;
  final String quantity;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,color: PaintColors.paralexpurple,size: 16,),
          SizedBox(height: 10),
          Text(
            quantity,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(
                color: Color(0xFF72777A),
                fontSize: 11,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String name;
  final String review;
  final int daysAgo;

  const ReviewCard({
    super.key,
    required this.name,
    required this.review,
    required this.daysAgo,
  });

  // Generate a seeded random color based on the name
  Color getSeededColor(String seedString) {
    // Convert the name into a numeric hash
    final hash = seedString.codeUnits.fold(0, (prev, element) => prev + element);
    final random = Random(hash); // Seed the random generator
    return Color.fromARGB(
      255,
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: getSeededColor(name), // Seeded color
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Name and time
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 10.0,
                  );
                }),
              ),
              SizedBox(width: 5),
              Text(
                '$daysAgo days ago',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Text(
            review,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

