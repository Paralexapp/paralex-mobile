import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../reusables/fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.desiredWidth,
    required this.buttonText,
    required this.buttonColor,
    this.ontap,
    this.loading = false,
  });

  final double desiredWidth;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback? ontap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: size.width * desiredWidth,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          onTap: ontap,
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    buttonText,
                    style: FontStyles.smallCapsIntro.copyWith(
                      color: Colors.white,
                      letterSpacing: 0,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ));
  }
}
