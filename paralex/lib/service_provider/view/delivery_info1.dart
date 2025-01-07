import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import '../../reusables/paints.dart';
import '../../routes/navs.dart';
import 'delivery_notification.dart';
import 'drawer.dart';

class DeliveryInfo1 extends StatelessWidget {
  DeliveryInfo1({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 15,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          // Background map image
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
                  // Top row with menu, balance, and notifications
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap:(){
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.menu, size: 24),
                        ),
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
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DeliveryNotification(
                                appBarTitle: "Notification",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.notifications_outlined, size: 24),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: size.height *
                      0.45, // Total height for the scrollable sheet
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.8,
                    minChildSize: 0.12,
                    maxChildSize: 0.8,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 40,
                                    height: 5,
                                    margin: const EdgeInsets.only(top: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "₦18.06",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 68,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEFF3FE),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/images/blank_human_image.svg"),
                                          Icon(
                                            Icons.star,
                                            size: 10,
                                            color: PaintColors.paralexpurple,
                                          ),
                                          Text(
                                            "5.0",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  height: 6,
                                  width: size.width * 0.78,
                                  decoration: BoxDecoration(
                                      color: PaintColors.paralexpurple,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.arrow_drop_down_circle_sharp,
                                          color: PaintColors.paralexpurple,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    "3 packages - Vip",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xFF21252C)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 16.0), // Add spacing as needed
                  child: CustomButton(
                      desiredWidth: 0.9,
                      buttonText: "Accept",
                      buttonColor: PaintColors.paralexpurple,
                      ontap: () {
                        Get.toNamed(Nav.deliveryInfo2);
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DottedLine extends StatelessWidget {
  const DottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
