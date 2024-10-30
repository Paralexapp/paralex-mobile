import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class SignupWidget extends StatelessWidget {
  const SignupWidget({super.key, required this.imgpath});

  final String imgpath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 44,
      decoration: BoxDecoration(
        color: Color(0xFFFFE4F2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child:  SvgPicture.asset(imgpath),
      ),
    );
  }
}