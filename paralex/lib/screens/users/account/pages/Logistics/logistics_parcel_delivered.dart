import 'package:flutter/material.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';

class LogisticsParcelDelivered extends StatelessWidget {
  const LogisticsParcelDelivered({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 7.0,
          ),
          child: Container(
            color: PaintColors.paralexGreyShade1,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: PaintColors.paralexpurple,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage('assets/images/highfive.png'),
                                fit: BoxFit.contain),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Congratulations!',
                          style: FontStyles.cancelTextStyle.copyWith(
                            color: Color(0xFF111A2C),
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'you parcel has been delivered',
                          style: FontStyles.cancelTextStyle.copyWith(
                            fontSize: 14,
                            color: Color(0xFF525C67),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
