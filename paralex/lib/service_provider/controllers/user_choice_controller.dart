import 'package:dio/dio.dart';
import 'package:get/get.dart';

class UserChoiceController extends GetxController {
  var isUser = true.obs; // default to "User"

  var email = ''.obs;

  var firstName =''.obs;

  var lastName =''.obs;

  String get userType => isUser.value ? 'USER' : 'SERVICE_PROVIDER';

  void selectUser() {
    isUser.value = true;
  }

  void selectServiceProvider() {
    isUser.value = false;
  }

 var userIdToken = ''.obs;
  var userEmail = ''.obs;
  // Authentication token (should be set after login)
  var authToken = ''.obs;

  Future<void> fetchLoggedInUser() async {
    if (authToken.value.isEmpty) {
      print('Error: Auth token is not set.');
      return;
    }

    final url = 'https://paralex-app-fddb148a81ad.herokuapp.com/api/v1/auth/get-user';
    try {
      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${authToken.value}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        firstName.value = data['firstName'] ?? '';
        lastName.value = data['lastName'] ?? '';
        email.value = data['email'] ?? '';
      } else {
        print('Failed to fetch logged-in user: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching logged-in user: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Uncomment the line below to fetch logged-in user after setting authToken
    fetchLoggedInUser();
  }
}


