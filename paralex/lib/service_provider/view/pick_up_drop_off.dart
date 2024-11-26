import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/package_detail_widget.dart';
import 'package:paralex/service_provider/view/widgets/pick_up_drop_off_nav_widget.dart';
import '../../enums/points.dart';
import '../../reusables/paints.dart';
import '../../routes/navs.dart';
import '../controllers/pick_up_drop_off_controller.dart';

class PickUpDropOff extends StatelessWidget {
  final PickUpDropOffController controller = Get.put(PickUpDropOffController());
  final points = Get.arguments as Points;
  @override
  Widget build(BuildContext context) {
    String pointName = points.name =="pickUpPoint" ? "Pick-up" :"Drop-off";
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 15,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
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
          Positioned(
            top: 20,
            left: 10,
            right: 20,
            child: PickUpDropOffNavWidget(
                points: points,
                tag: "A",
                address: "8 County Road 11/6",
                addressContd: "Mannington,wv,26582 United States"),
          ),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              controller.handleSheetSizeChange(notification.extent);
              return true;
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.15,
              maxChildSize: 1.0,
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
                      // Drag handle bar
                      Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Scrollable content
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: [
                            // Reactively display the expanded content
                            Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (controller.isExpanded.value)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.tune, size: 28),
                                          Text(
                                            "1 order for $pointName",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(Icons.list, size: 28),
                                        ],
                                      ),
                                    ),
                                  if (controller.isExpanded.value)
                                    SizedBox(height: 15),
                                  if (controller.isExpanded.value) Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (!controller.isExpanded.value)
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Color(0xFFE4E9F2),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/images/blue_blank_human_image.svg",
                                            ),
                                          ),
                                        SlideTransition(
                                          position: controller.textAnimation,
                                          child: Text(
                                            "Rebecca",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.white,
                                          ),
                                          child: Icon(Icons.phone_outlined),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Text(
                                      "Note from user",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.circle,size: 5),
                                        SizedBox(width: 10),
                                        Text(
                                          "My house is next to the department store",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "8 County Road 11/6",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Mannington,wv, 26582  United States",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
                                    child: Text(
                                      "Package Information",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
                                    child: Text(
                                      "Number Of Packages: 2",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                    child: PackageDetailWidget(),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 1,
              width: double.infinity,
              color: Color(0xFFB5B5B5),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(Icons.warning, color: Color(0xFF21252C)),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: CustomButton(
                    desiredWidth: 0.5,
                    buttonText: "Arrived",
                    buttonColor: PaintColors.paralexpurple,
                    ontap: (){
                      Get.toNamed(Nav.pickUpDetail,arguments: pointName);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




