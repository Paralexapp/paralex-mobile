import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';
import '../../routes/navs.dart';
import '../controllers/user_choice_controller.dart';
import '../services/api_service.dart';
import 'package:get/get.dart';

final userController = Get.find<UserChoiceController>();

class NotificationDetailScreen extends StatefulWidget {
  final String title;
  final String message;
  final String notificationId;
  final String appBarTitle;

  const NotificationDetailScreen({
    super.key,
    required this.title,
    required this.message,
    required this.notificationId,
    required this.appBarTitle,
  });

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  final ApiService apiService = ApiService();
  bool isLoading = true;
  bool _buttonsActive = true;

  @override
  void initState() {
    super.initState();
    markAsRead();
  }

  Future<void> markAsRead() async {
    if (widget.notificationId.isEmpty) {
      debugPrint('Error: Notification ID is empty.');
      return;
    }

    try {
      late String endpoint;
      String userId;

      if (widget.appBarTitle.toLowerCase() == "message") {
        if (userController.selectedUserType.value == UserType.USER) {
          endpoint =
              "https://paralex-be.onrender.com/api/notifications/inbox/mark-as-read";
        } else if (userController.selectedUserType.value ==
            UserType.SERVICE_PROVIDER_LAWYER) {
          endpoint =
              "https://paralex-be.onrender.com/api/notifications/inbox/lawyer/mark-as-read";
        } else if (userController.selectedUserType.value ==
            UserType.SERVICE_PROVIDER_RIDER) {
          endpoint =
              "https://paralex-be.onrender.com/api/notifications/inbox/rider/mark-as-read";
        }
        userId = userController.userIdToken.value;
      } else {
        if (userController.selectedUserType.value == UserType.USER) {
          endpoint =
              "https://paralex-be.onrender.com/api/notifications/mark-as-read";
        } else if (userController.selectedUserType.value ==
            UserType.SERVICE_PROVIDER_LAWYER) {
          endpoint =
              "https://paralex-be.onrender.com/api/notifications/lawyer/mark-as-read";
        } else if (userController.selectedUserType.value ==
            UserType.SERVICE_PROVIDER_RIDER) {
          endpoint =
              "https://paralex-be.onrender.com/api/notifications/rider/mark-as-read";
        }
        userId = "null";
      }
      final queryParams = {
        'notificationId': widget.notificationId,
        'userId': userId,
      };
      final queryString = Uri(queryParameters: queryParams).query;
      final fullEndpoint = '$endpoint?$queryString';

      debugPrint('Making POST request to: $fullEndpoint');
      final response = await http.post(
        Uri.parse(fullEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({}), // Sending an empty body
      );

      // Handle the response
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          debugPrint(
              'Notification marked as read successfully with no response body.');
        } else {
          debugPrint('Notification marked as read: ${response.body}');
        }
      } else {
        debugPrint(
            'Error: Failed to mark notification as read. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isNewDeliveryRequest = widget.message.toLowerCase().contains("new delivery request");

    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: widget.appBarTitle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: FontStyles.smallCapsIntro.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF21252C),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.message,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF76889A),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            if (isNewDeliveryRequest) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PaintColors.paralexGreen,
                    ),
                    onPressed: _buttonsActive
                        ? () async {
                      await _respondToRequest("accept");
                    }
                        : null, // Set to null to disable
                    child: const Text("Accept"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PaintColors.paralexpurple,
                    ),
                    onPressed: _buttonsActive
                        ? () async {
                      await _respondToRequest("decline");
                    }
                        : null, // Set to null to disable
                    child: const Text("Decline"),
                  ),
                ],
              )
            ],
          ],
        ),
      ),
    );
  }


// @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomAppBar(
  //       appBarTitle: widget.appBarTitle,
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(25.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             widget.title,
  //             style: FontStyles.smallCapsIntro.copyWith(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xFF21252C),
  //               letterSpacing: 0.5,
  //             ),
  //           ),
  //           const SizedBox(height: 20),
  //           Text(
  //             widget.message,
  //             style: TextStyle(
  //               fontSize: 16,
  //               color: Color(0xFF76889A),
  //               height: 1.5,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


  Future<void> _respondToRequest(String action) async {

    setState(() {
      _buttonsActive = false; // Disable buttons immediately on press
    });
    // 1. Extract the delivery ID from the message
    String? deliveryId;
    // UPDATED REGEX: Added a space after 'id'
    final RegExp regExp = RegExp(r"with id (\S+) is available"); // Matches "with id " (with a space) followed by non-space characters until " is available"
    final match = regExp.firstMatch(widget.message);

    if (match != null && match.groupCount > 0) {
      deliveryId = match.group(1); // The first captured group is the ID
      debugPrint('Extracted Delivery ID: $deliveryId');
    } else {
      Get.snackbar("Error", "Could not find delivery ID in message.");
      setState(() {
        _buttonsActive = true; // Re-enable if ID extraction fails
      });
      return; // Stop execution if ID is not found
    }
    // Get.back();
    try {
      final ApiService apiService = ApiService();

      final response = await apiService.putRequest(
        'delivery/request/assignment/$action',
        {"id": deliveryId}, // Use the extracted deliveryId here
        requireAuth: true,
      );

      Get.snackbar("Success", "You have ${action}ed the request!");
       // Optionally go back after action

      if (action == "accept") {
        // Navigate to success screen for rider
        Get.toNamed(Nav.deliveryAccepted, arguments: {'deliveryId': deliveryId});
      } else {
        Get.toNamed(Nav.deliveryInfo1, arguments: {'deliveryId': deliveryId});// Navigate back on decline or others
      }
      // Get.back();
    } catch (e) {
      // Get.snackbar("Error", "Failed to $action request: $e");
      setState(() {
        _buttonsActive = true;
      });
    }
  }
}

  // Future<void> _respondToRequest(String action) async {
  //   try {
  //     final ApiService apiService = ApiService();
  //
  //     final response = await apiService.putRequest(
  //       'delivery/request/assignment/$action',
  //       {"id": widget.notificationId},
  //       requireAuth: false,
  //     );
  //
  //     Get.snackbar("Success", "You have ${action}ed the request!");
  //     Get.back(); // Optionally go back after action
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to $action request: $e");
  //   }
  // }




class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  const CustomAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: PaintColors.paralexpurple,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      title: Text(
        "$appBarTitle details",
        style: FontStyles.smallCapsIntro.copyWith(
          fontSize: 16,
          letterSpacing: 0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}


