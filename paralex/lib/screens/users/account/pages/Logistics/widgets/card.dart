import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/screens/users/account/pages/controllers/logistics_payment_method_controller.dart';

class PaymentCard extends StatelessWidget {
  PaymentCard({super.key, this.selected = false, this.text, this.image});
  final LogisticsPaymentMethodController controller =
  Get.put(LogisticsPaymentMethodController());
  final String? image;
  final String? text;
  final bool? selected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 15,width: 100,),
              Container(
                  height: 72,
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PaintColors.paralexGreyShade3,
                    border: selected == false ? null : Border.all(color: PaintColors.paralexpurple, width: 2),
                  ),
                  child: Center(
                    child: Image.asset(image.toString(), fit: BoxFit.contain,height: 35,width: 55,),
                  )
              ),
              Text(text.toString(), style: FontStyles.cancelTextStyle.copyWith(color: PaintColors.paralexTextColor2, fontSize: 14),),
            ],
          ),
          if (selected == true) Positioned(
            right: 0,
            top: 7,
            child: Center(child: Icon(Iconsax.tick_circle, color: PaintColors.paralexpurple),
            ),
            // child: Center(child: Icon(Icons.check_circle_rounded, color: PaintColors.paralexpurple)),
          )
        ],
      ),
    );
  }
}
