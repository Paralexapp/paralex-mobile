import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../reusables/paints.dart';
import '../controllers/notification_controller.dart';
import 'delivery_notification.dart';
import 'drawer.dart';

class DeliveryInfo1 extends StatefulWidget {
  DeliveryInfo1({Key? key}) : super(key: key);

  @override
  State<DeliveryInfo1> createState() => _DeliveryInfo1State();
}

class _DeliveryInfo1State extends State<DeliveryInfo1> {
  final NotificationsController notificationsController = Get.find<NotificationsController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late GoogleMapController mapController;
  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

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
          // Replaced static background with Google Maps
          currentPosition == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentPosition!,
              zoom: 15,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),

          // Top bar with drawer icon, balance, and notification bell
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
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
                      // child: Text(
                      //   "₦0",
                      //   style: TextStyle(color: Colors.black, fontSize: 24),
                      // ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DeliveryNotification(appBarTitle: "Message"),
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

          // Draggable Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: size.height * 0.45,
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.8,
                    minChildSize: 0.12,
                    maxChildSize: 0.8,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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

                                // Amount & Rating Row (commented out)
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("₦18.06", style: TextStyle(...)),
                                //     ...Rating widget...
                                //   ],
                                // ),

                                SizedBox(height: 20),
                                Container(
                                  height: 6,
                                  width: size.width * 0.78,
                                  decoration: BoxDecoration(
                                    color: PaintColors.paralexpurple,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(height: 20),

                                // Notifications Section
                                Obx(() {
                                  final messages = notificationsController.inboxMessages;
                                  if (messages.isEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text("No notifications available"),
                                    );
                                  }

                                  final reversedMessages = messages.reversed.toList(); // Newest first

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(0),
                                    itemCount: reversedMessages.length,
                                    itemBuilder: (context, index) {
                                      final notification = reversedMessages[index];
                                      return NotificationWidget(
                                        notification: notification,
                                        appBarTitle: "Message",
                                      );
                                    },
                                  );
                                }),


                                // Notifications Section
                                // Obx(() {
                                //   final messages = notificationsController.inboxMessages;
                                //   if (messages.isEmpty) {
                                //     return Padding(
                                //       padding: const EdgeInsets.all(16.0),
                                //       child: Text("No notifications available"),
                                //     );
                                //   }
                                //   return ListView.builder(
                                //     shrinkWrap: true,
                                //     physics: NeverScrollableScrollPhysics(),
                                //     padding: const EdgeInsets.all(0),
                                //     itemCount: messages.length,
                                //     itemBuilder: (context, index) {
                                //       final notification = messages[index];
                                //       return NotificationWidget(
                                //         notification: notification,
                                //         appBarTitle: "Message",
                                //       );
                                //     },
                                //   );
                                // }),

                                SizedBox(height: 16),

                                // Delivery Address Row (commented out)
                                // Row(
                                //   children: [
                                //     Icon(Icons.location_on, color: Colors.red),
                                //     SizedBox(width: 8),
                                //     Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Text("1124 Cave Road", style: TextStyle(...)),
                                //         Text("Gillette, WV, 26582, United States", style: TextStyle(...)),
                                //       ],
                                //     ),
                                //   ],
                                // ),

                                // Additional Order Info
                                // Divider(),
                                // Text("3 packages - Vip", style: TextStyle(...)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),

                // Accept Button (commented out)
                // Padding(
                //   padding: EdgeInsets.only(bottom: 16.0),
                //   child: CustomButton(
                //     desiredWidth: 0.9,
                //     buttonText: "Accept",
                //     buttonColor: PaintColors.paralexpurple,
                //     ontap: () {
                //       Get.toNamed(Nav.deliveryInfo2);
                //     },
                //   ),
                // ),
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


// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../reusables/paints.dart';
// import '../controllers/notification_controller.dart';
// import 'delivery_notification.dart';
// import 'drawer.dart';
//
// class DeliveryInfo1 extends StatefulWidget {
//   DeliveryInfo1({Key? key}) : super(key: key);
//
//   @override
//   State<DeliveryInfo1> createState() => _DeliveryInfo1State();
// }
//
// class _DeliveryInfo1State extends State<DeliveryInfo1> {
//   final NotificationsController notificationsController = Get.find<NotificationsController>();
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   late GoogleMapController mapController;
//   LatLng? currentPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//   }
//
//   Future<void> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled.
//       // You might want to prompt the user to enable it.
//       return;
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied.
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are permanently denied.
//       return;
//     }
//
//     // When permissions are granted, get the current position.
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       currentPosition = LatLng(position.latitude, position.longitude);
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         toolbarHeight: 15,
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       drawer: const MyDrawer(),
//       body: Stack(
//         children: [
//           // Background map image
//           // Container(
//           // Replace static image with Google Map centered on current location
//           currentPosition == null
//               ? Center(child: CircularProgressIndicator())
//               : GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: currentPosition!,
//               zoom: 15,
//             ),
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//             },
//           ),
//             // decoration: const BoxDecoration(
//             //   image: DecorationImage(
//             //     image: AssetImage("assets/images/map.jpg"),
//             //     fit: BoxFit.cover,
//             //   ),
//             // ),
//             Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 children: [
//                   // Top row with menu, balance, and notifications
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap:(){
//                           _scaffoldKey.currentState!.openDrawer();
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Icon(Icons.menu, size: 24),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           "₦0",
//                           style: TextStyle(color: Colors.black, fontSize: 24),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: (){
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => DeliveryNotification(
//                                 appBarTitle: "Message",
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Icon(Icons.notifications_outlined, size: 24),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           // ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   height: size.height *
//                       0.45, // Total height for the scrollable sheet
//                   child: DraggableScrollableSheet(
//                     initialChildSize: 0.8,
//                     minChildSize: 0.12,
//                     maxChildSize: 0.8,
//                     builder: (context, scrollController) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(20),
//                           ),
//                         ),
//                         child: SingleChildScrollView(
//                           controller: scrollController,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Center(
//                                   child: Container(
//                                     width: 40,
//                                     height: 5,
//                                     margin: const EdgeInsets.only(top: 8),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[400],
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     // Text(
//                                     //   "₦18.06",
//                                     //   style: TextStyle(
//                                     //       color: Colors.black,
//                                     //       fontSize: 24,
//                                     //       fontWeight: FontWeight.bold),
//                                     // ),
//                                     // Container(
//                                     //   width: 68,
//                                     //   height: 28,
//                                     //   decoration: BoxDecoration(
//                                     //     color: Color(0xFFEFF3FE),
//                                     //     borderRadius: BorderRadius.circular(20),
//                                     //   ),
//                                     //   child: Row(
//                                     //     children: [
//                                     //       SvgPicture.asset(
//                                     //           "assets/images/blank_human_image.svg"),
//                                     //       Icon(
//                                     //         Icons.star,
//                                     //         size: 10,
//                                     //         color: PaintColors.paralexpurple,
//                                     //       ),
//                                     //       Text(
//                                     //         "5.0",
//                                     //         style: TextStyle(
//                                     //             color: Colors.black,
//                                     //             fontSize: 11),
//                                     //       )
//                                     //     ],
//                                     //   ),
//                                     // )
//                                   ],
//                                 ),
//                                 SizedBox(height: 20),
//                                 Container(
//                                   height: 6,
//                                   width: size.width * 0.78,
//                                   decoration: BoxDecoration(
//                                       color: PaintColors.paralexpurple,
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                                 SizedBox(height: 20),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       // children: [
//                                       //   Icon(
//                                       //     Icons.arrow_drop_down_circle_sharp,
//                                       //     color: PaintColors.paralexpurple,
//                                       //   ),
//                                       //   SizedBox(height: 4),
//                                       //   // DottedLine(), // Custom dashed line
//                                       // ],
//                                     ),
//                                     SizedBox(width: 8),
//
//                                     Obx(() {
//                                       final messages = notificationsController.inboxMessages;
//                                       if (messages.isEmpty) {
//                                         return Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Text("No notifications available"),
//                                         );
//                                       }
//
//                                       return ListView.builder(
//                                         shrinkWrap: true,
//                                         physics: NeverScrollableScrollPhysics(), // prevent internal scrolling
//                                         padding: const EdgeInsets.all(16.0),
//                                         itemCount: messages.length,
//                                         itemBuilder: (context, index) {
//                                           final notification = messages[index];
//                                           return NotificationWidget(
//                                             notification: notification,
//                                             appBarTitle: "Message",
//                                           );
//                                         },
//                                       );
//                                     })
//
//
//                                     // Column(
//                                     //   crossAxisAlignment:
//                                     //       CrossAxisAlignment.start,
//                                     //   children: [
//                                     //     Text(
//                                     //       "No Order Yet!",
//                                     //       style: TextStyle(
//                                     //           fontWeight: FontWeight.bold,
//                                     //           fontSize: 16,
//                                     //           color: Color(0xFF21252C)),
//                                     //     ),
//                                     //     // Text(
//                                     //     //   "Mannington, WV, 26582, United States",
//                                     //     //   style: TextStyle(
//                                     //     //       color: Colors.grey[700]),
//                                     //     // ),
//                                     //   ],
//                                     // ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 16),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       // children: [
//                                       //   Icon(Icons.location_on,
//                                       //       color: Colors.red),
//                                       //   SizedBox(height: 4),
//                                       // ],
//                                     ),
//                                     SizedBox(width: 8),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         // Text(
//                                         //   "1124 Cave Road",
//                                         //   style: TextStyle(
//                                         //       fontWeight: FontWeight.bold,
//                                         //       fontSize: 16,
//                                         //       color: Color(0xFF21252C)),
//                                         // ),
//                                         // Text(
//                                         //   "Gillette, WV, 26582, United States",
//                                         //   style: TextStyle(
//                                         //       color: Colors.grey[700]),
//                                         // ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 // Divider(),
//                                 // Padding(
//                                 //   padding: const EdgeInsets.only(bottom: 5.0),
//                                 //   child: Text(
//                                 //     "3 packages - Vip",
//                                 //     style: TextStyle(
//                                 //         fontSize: 14, color: Color(0xFF21252C)),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Padding(
//                 //   padding:
//                 //       EdgeInsets.only(bottom: 16.0), // Add spacing as needed
//                 //   child: CustomButton(
//                 //       desiredWidth: 0.9,
//                 //       buttonText: "Accept",
//                 //       buttonColor: PaintColors.paralexpurple,
//                 //       ontap: () {
//                 //         Get.toNamed(Nav.deliveryInfo2);
//                 //       }),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DottedLine extends StatelessWidget {
//   const DottedLine({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 40,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: List.generate(
//           6,
//           (index) => Container(
//             width: 2,
//             height: 2,
//             color: Colors.grey,
//           ),
//         ),
//       ),
//     );
//   }
// }
