import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ExceptionHandler{
  static Future<void> handleException(dynamic exception) async {
    if (exception is FirebaseException) {
      FirebaseException e = exception;
      Get.snackbar("Error", "${e.message}");
    }
    throw exception;
  }
}