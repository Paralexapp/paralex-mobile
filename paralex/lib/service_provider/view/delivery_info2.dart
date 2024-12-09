import 'package:flutter/material.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/pick_up_drop_off_widget.dart';
import '../../enums/points.dart';
import '../../reusables/paints.dart';
import 'drawer.dart';

class DeliveryInfo2 extends StatelessWidget {
  const DeliveryInfo2({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 15,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: MyDrawer(),
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
          ),
          // Top row with menu, balance, and notifications
          Positioned(
            top: 25, // Adjust top margin as needed
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: (){
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.menu, size: 24),
                      ),
                    );
                  }
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 100),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: DraggableScrollableSheet(
                initialChildSize: 0.35,
                minChildSize: 0.07,
                maxChildSize: 1,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Total Earnings",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "₦35.6",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.only(right: 24),
                                    child: VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Packages",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "3",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25),
                            Text(
                              "Total distance: 478 km",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Change",
                                style: TextStyle(
                                    color: PaintColors.paralexpurple,
                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(height: 15),
                            PickUpDropOffWidget(
                                points: Points.pickUpPoint,
                                tag: "A",
                                address: "8 County Road 11/6",
                                addressContd:
                                    "Mannington,wv,26582 United States"),
                            SizedBox(height: 15),
                            PickUpDropOffWidget(
                                points: Points.dropOffPoint,
                                tag: "A",
                                address: "1124 Cave Road",
                                addressContd:
                                    "Gillete,wv, 26582 United States"),
                            SizedBox(height: 15),
                            PickUpDropOffWidget(
                                points: Points.pickUpPoint,
                                tag: "B",
                                address: "1132 County Road 11/6",
                                addressContd:
                                    "Mannington,wv, 78782 United States"),
                            SizedBox(height: 15),
                            PickUpDropOffWidget(
                                points: Points.dropOffPoint,
                                tag: "B",
                                address: "567 William Road",
                                addressContd:
                                    "Gillete,wv, 26582 United States"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.0, right: 16, left: 16),
              child: CustomButton(
                desiredWidth: 0.9,
                buttonText: "Go Now",
                buttonColor: PaintColors.paralexpurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



