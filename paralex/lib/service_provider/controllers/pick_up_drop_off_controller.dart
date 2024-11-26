import 'package:get/get.dart';
import 'package:flutter/animation.dart';

class PickUpDropOffController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> textAnimation;

  // Use RxBool to make isExpanded reactive
  RxBool isExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize animation controller and animation
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    textAnimation = Tween<Offset>(
      begin: Offset(0, 0), // Initial position (center)
      end: Offset(0, 0), // Move text far left
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
  }

  // Method to handle the sheet size change
  void handleSheetSizeChange(double extent) {
    if (extent == 1.0 && !isExpanded.value) {
      isExpanded.value = true;
      animationController.forward();
    } else if (extent < 1.0 && isExpanded.value) {
      isExpanded.value = false;
      animationController.reverse();
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
