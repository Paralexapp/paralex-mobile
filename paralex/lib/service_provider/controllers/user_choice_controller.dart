import 'package:get/get.dart';

class UserChoiceController extends GetxController {
  var isUser = true.obs; // default to "User"

  void selectUser() {
    isUser.value = true;
  }

  void selectServiceProvider() {
    isUser.value = false;
  }

 var userIdToken = ''.obs;
  var userEmail = ''.obs;

}
