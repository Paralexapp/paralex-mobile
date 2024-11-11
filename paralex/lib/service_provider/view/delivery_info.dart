import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/service_provider/view/widgets/custom_button.dart';
import 'package:paralax/service_provider/view/widgets/custom_text_field.dart';

import '../../reusables/fonts.dart';

class DeliveryInfo extends StatefulWidget {
  const DeliveryInfo({super.key});

  @override
  State<DeliveryInfo> createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 15,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background map image and main content
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/map.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.menu, size: 24),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "₦0",
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.notifications_outlined, size: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: isOnline ? 0.1 : 0.87,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                isOnline ? "You're Offline" : "You're Online",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Add additional details or widgets here
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Set up your upcoming trip",
                                  style: FontStyles.smallCapsIntro.copyWith(
                                      fontSize: 20,
                                      color: Color(0xFF21252C),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0),
                                ),
                                Transform.translate(
                                  offset: Offset(220, -20),
                                  child: Image.asset(
                                      "assets/images/delivery_truck.png"),
                                ),
                                Transform.translate(
                                  offset: Offset(0, -30),
                                  child: Text(
                                    "Tell us about your trip and help transport\ngoods to everyone",
                                    style: FontStyles.smallCapsIntro.copyWith(
                                        fontSize: 14,
                                        color: Color(0xFF21252C),
                                        letterSpacing: 0),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0, -10),
                                  child: CustomTextField(
                                    hintText: "Your destination",
                                    suffixIcon: Icon(
                                      Icons.location_on_sharp,
                                      color: Color(0xFFADAEB9),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                CustomButton(
                                    desiredWidth: 0.9,
                                    buttonText: "Set Up",
                                    buttonColor: PaintColors.paralaxpurple),
                                SizedBox(height: 15),
                                Text(
                                  "My schedule",
                                  style: FontStyles.smallCapsIntro.copyWith(
                                      fontSize: 20,
                                      color: Color(0xFF21252C),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Upcoming",
                                  style: FontStyles.smallCapsIntro.copyWith(
                                      fontSize: 17,
                                      color: Color(0xFF21252C),
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Top row with date and location
                                      Row(
                                        children: [
                                          Image.asset(
                                              "assets/images/package.png"),
                                          SizedBox(width: 8),
                                          Text(
                                            "15/07/2023 | San Jose",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF21252C)),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.navigate_next,
                                            color: Color(0xFF21252C),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                  Icons.arrow_drop_down_circle_sharp, color: Colors.blue,
                                              ),
                                              SizedBox(height: 4),
                                              DottedLine(), // Custom dashed line
                                            ],
                                          ),
                                          SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "8 County Road 11/6",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Color(0xFF21252C)),
                                              ),
                                              Text(
                                                "Mannington, WV, 26582, United States",
                                                style: TextStyle(
                                                    color: Colors.grey[700]),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Icon(Icons.location_on,
                                                  color: Colors.red),
                                              SizedBox(height: 4),
                                            ],
                                          ),
                                          SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "1124 Cave Road",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Color(0xFF21252C)),
                                              ),
                                              Text(
                                                "Gillette, WV, 26582, United States",
                                                style: TextStyle(
                                                    color: Colors.grey[700]),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "See all schedule",
                                        style: FontStyles.smallCapsIntro
                                            .copyWith(
                                                fontSize: 12,
                                                color:
                                                    PaintColors.paralaxpurple,
                                                letterSpacing: 0),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.white,
        shape: CircularNotchedRectangle(), // Creates a notch for the FAB
        notchMargin: 6.0, // Margin around the FAB notch
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 1, // height of the line
              width: double.infinity, // full width
              color: Color(0xFFB5B5B5), // color of the line
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.calendar_today, color: Color(0xFF21252C)),
                  onPressed: () {
                    // Handle Home button tap
                  },
                ),
                CustomButton(
                  desiredWidth: 0.5,
                  buttonText: isOnline ? "Go Online" : "Go Offline",
                  buttonColor: PaintColors.paralaxpurple,
                  ontap: () {
                    setState(() {
                      isOnline = !isOnline;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.tune, color: Color(0xFF21252C)),
                  onPressed: () {
                    // Handle Search button tap
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom dashed line widget
class DottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          6,
          (index) => Container(
            width: 2,
            height: 2,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
