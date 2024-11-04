import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../reusables/fonts.dart';

class SelectServiceWidget extends StatelessWidget {
  const SelectServiceWidget(
      {super.key,
        required this.imgPath,
        required this.firstText,
        required this.secondText,
        required this.thirdText,
        required this.bckgColor});

  final String imgPath;
  final String firstText;
  final String secondText;
  final String thirdText;
  final Color bckgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: bckgColor,
          border: Border.all(
            color: const Color(0xFFD1D1D1),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(imgPath),
          Text(
            firstText,
            style: FontStyles.contentText
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 3),
          Text(
            secondText,
            style: FontStyles.contentText,
          ),
          Transform.translate(
            offset: const Offset(0,-5),
            child: Text(
              thirdText,
              style: FontStyles.contentText,
            ),
          ),
        ],
      ),
    );
  }
}