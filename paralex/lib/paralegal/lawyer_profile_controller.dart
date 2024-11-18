import 'package:get/get.dart';
class LawyerProfileController extends GetxController {
  var reviews = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  void fetchReviews() async {
    // Simulate fetching data from the backend
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    reviews.value = [
      {
        "name": "Johnbull Ekanem",
        //"text": "Johnbull's review text goes here.",
        "rating": "4.5",
        "imagePath": null
      },
      {
        "name": "Olusegun Obasanjo",
        "text": "Olusegun's review text goes here.",
        "rating": "4.8",
        "imagePath": null
      },
      {
        "name": "Elon Musk",
        "text": "Musk's review text goes here.",
        "rating": "4.5",
        "imagePath": null
      },
    ];
  }
}