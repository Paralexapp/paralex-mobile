import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/card.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_button.dart';
import 'package:paralex/screens/users/account/pages/controllers/logistics_payment_method_controller.dart';

class LogisticsPaymentMethod extends StatelessWidget {
  LogisticsPaymentMethod({super.key});
  final LogisticsPaymentMethodController controller =
      Get.put(LogisticsPaymentMethodController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: Container(
            color: PaintColors.paralexGreyShade1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 25),
                  child: LogisticsCloseButton(
                    text: 'Payment',
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: PaintColors.paralexTextColor1,
                      size: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ListView.builder(
                      padding: EdgeInsets.only(left: 25),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.paymentCards.length,
                      itemBuilder: (_, index) {
                        var e = controller.paymentCards[index];
                        return InkWell(
                          onTap: () {
                            // controller.updateSelected(!e.selected, index);
                          },
                          child: PaymentCard(
                            image: e.image,
                            text: e.text,
                            selected: e.selected,
                          ),
                        );
                      }),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: PaintColors.paralexGreyShade4,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 168,
                            height: 106,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              // color: Colors.green,
                              image: DecorationImage(
                                  image: AssetImage('assets/images/samplecard.png'),
                                  fit: BoxFit.fitWidth),
                            ),
                            // child: Image.asset('assets/images/map.png', width: 168, height: 106, fit: BoxFit.cover,),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'No master card added',
                            style: FontStyles.cancelTextStyle.copyWith(
                                color: Color(0xFF32343E), fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'You can add a mastercard and\n save it for later',
                            style: FontStyles.cancelTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.7,
                                color: Color(0xFF8C8CA1)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: deviceWidth(context),
                      height: 48,
                      decoration: BoxDecoration(
                        color: PaintColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: PaintColors.paralexpurple),
                            SizedBox(width: 5),
                            Text(
                              'ADD NEW',
                              style: FontStyles.cancelTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: PaintColors.paralexpurple,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 55),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'TOTAL:',
                        style: FontStyles.cancelTextStyle.copyWith(
                          fontSize: 14,
                          color: Color(0xFFA0A5BA),
                        ),
                      ),
                      Text(
                        'N906',
                        style: FontStyles.cancelTextStyle.copyWith(
                          color: PaintColors.paralexTextColor1,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: LogisticsButton(
                    text: 'PAY & CONFIRM',
                    onTap: () {
                      Get.toNamed(Nav.logisticsPaymentMethod2);
                    },
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
