import 'package:flutter/material.dart';

import '../../../../reusables/fonts.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.desiredWidth,
    required this.buttonText,
    required this.buttonColor,
    this.ontap,
  });

  final double desiredWidth;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: size.width * desiredWidth,
      decoration:  BoxDecoration(
        color:  buttonColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: ontap,
        child: Center(
          child: Text(
            buttonText,
            style: FontStyles.smallCapsIntro.copyWith(
              color: Colors.white,
              letterSpacing: 0,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}