import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';

class LogisticsButton extends StatelessWidget {
  LogisticsButton({super.key, required this.text, this.check = false, this.onTap});
  final String? text;
  bool check;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        width: deviceWidth(context),
        height: 48,
        decoration: BoxDecoration(
          color: check ? PaintColors.fadedPink : PaintColors.paralexpurple,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(text.toString(), style: FontStyles.cancelTextStyle.copyWith(fontWeight: FontWeight.w700, color: PaintColors.white),)),
      ),
    );
  }
}

class LogisticsCancelButton extends StatelessWidget {
  const LogisticsCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: (){
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0,bottom: 8.0,top: 5),
            child: Text('Cancel', style: FontStyles.cancelTextStyle),
          ),
        ),
      ],);
  }
}

