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

}
