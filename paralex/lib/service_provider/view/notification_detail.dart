import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';
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
  State<NotificationDetailScreen> createState() => _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {

  final ApiService apiService = ApiService();
  bool isLoading = true;

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
      String endpoint;
      String userId;

      if (widget.appBarTitle.toLowerCase() == "message") {
        endpoint = "https://paralex-app-fddb148a81ad.herokuapp.com/api/notifications/inbox/mark-as-read";
        userId = userController.userIdToken.value;
      } else {
        endpoint = "https://paralex-app-fddb148a81ad.herokuapp.com/api/notifications/mark-as-read";
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
          debugPrint('Notification marked as read successfully with no response body.');
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
    return Scaffold(
      appBar:  CustomAppBar(appBarTitle: widget.appBarTitle,),
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
          ],
        ),
      ),
    );
  }
}

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
        "$appBarTitle details" ,
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
