import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';

class LogisticsButton extends StatelessWidget {
  LogisticsButton(
      {super.key,
      required this.text,
      this.check = false,
      this.onTap,
      this.textColor,
      this.isLoading = false});
  final String? text;
  bool check;
  bool isLoading;
  final Color? textColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: deviceWidth(context),
        height: 48,
        decoration: BoxDecoration(
          color: check ? PaintColors.fadedPink : PaintColors.paralexpurple,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    text.toString(),
                    style: FontStyles.cancelTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: textColor ?? PaintColors.white),
                  )),
      ),
    );
  }
}

class LogisticsCancelButton extends StatelessWidget {
  const LogisticsCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, bottom: 8.0, top: 5),
            child: Text('Cancel', style: FontStyles.cancelTextStyle),
          ),
        ),
      ],
    );
  }
}

class LogisticsCloseButton extends StatelessWidget {
  const LogisticsCloseButton({super.key, this.text, this.icon});
  final String? text;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PaintColors.paralexGreyShade2,
            ),
            child: icon,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          text.toString(),
          style: FontStyles.cancelTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: PaintColors.paralexTextColor1,
          ),
        )
      ],
    );
  }
}
