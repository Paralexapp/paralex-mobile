import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';
import '../../../../../../service_provider/view/widgets/custom_button.dart';


class BondSuccess extends StatelessWidget {
  const BondSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Icon(
                Iconsax.copy_success,
                size: 100,
                color: Colors.green,
              ),
              const Text(
                "Bond Submitted successfully",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  desiredWidth: 70,
                  buttonText: "Go back to home",
                  buttonColor: PaintColors.paralaxpurple,
                  ontap: () => Get.toNamed(Nav.paralegalHome))
            ],
          ),
        ),
      ),
    );
  }
}
