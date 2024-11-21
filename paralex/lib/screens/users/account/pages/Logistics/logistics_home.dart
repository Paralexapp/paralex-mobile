import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';
import 'package:paralex/routes/navs.dart';

import 'widgets/logistics_button.dart';
import 'widgets/logistics_textfield.dart';

class LogisticsHome extends StatelessWidget {
  const LogisticsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SizedBox(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 12.0,),
                SizedBox(
                  height: deviceHeight(context) * 0.45,
                  width: deviceWidth(context),
                  child: Image.asset('assets/images/map.jpg', fit: BoxFit.cover,),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: deviceHeight(context) * 0.92,
                width: deviceWidth(context),
                decoration: BoxDecoration(
                  color: PaintColors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 25, right: 25, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: deviceWidth(context) * 0.2,
                          height: 5,
                          decoration: BoxDecoration(
                            color: PaintColors.paralexLightGrey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text('Order details', style: FontStyles.bodyText1,),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Where to pick up', style: FontStyles.bodyText1,),
                          ],
                        ),
                        SizedBox(height: 8,),
                        SizedBox(
                          width: deviceWidth(context),
                          child: Row(
                            children: [
                            SizedBox(
                              width: deviceWidth(context) * 0.58,
                              child: LogisticsTextfield(
                              hintText: 'Street',
                            ),),
                              Spacer(),
                              // SizedBox(width: 8),
                              SizedBox(
                                width: deviceWidth(context) * 0.24,
                                child: LogisticsTextfield(
                                  hintText: 'Entran...',
                                ),),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        LogisticsTextfield(
                          hintText: 'Floor, apartment, entryphone',
                        ),
                        SizedBox(height: 8,),
                        LogisticsTextfield(
                          hintText: 'Sender phone number',
                          suffixIcon: Iconsax.call,
                          showSuffixIcon: true,
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Where to deliver', style: FontStyles.bodyText1,),
                          ],
                        ),
                        SizedBox(height: 8,),
                        SizedBox(
                          width: deviceWidth(context),
                          child: Row(
                            children: [
                              SizedBox(
                                width: deviceWidth(context) * 0.58,
                                child: LogisticsTextfield(
                                  hintText: 'Street',
                                ),),
                              // SizedBox(width: 8),
                              Spacer(),
                              SizedBox(
                                width: deviceWidth(context) * 0.24,
                                child: LogisticsTextfield(
                                  hintText: 'Entran...',
                                ),),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        LogisticsTextfield(
                          hintText: 'Floor, apartment, entryphone',
                        ),
                        SizedBox(height: 8,),
                        LogisticsTextfield(
                          hintText: 'Recipient phone number',
                          suffixIcon: Iconsax.call,
                          showSuffixIcon: true,
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('What to deliver', style: FontStyles.bodyText1,),
                          ],
                        ),
                        SizedBox(height: 8,),
                        LogisticsTextfield(
                          hintText: 'Example: Medium-sized box with legal documents that weight 5kg',
                          maxLines: 4,
                        ),
                        SizedBox(height: 18,),
                        LogisticsButton(text: 'SAVE',
                          check: false,
                          onTap: (){
                            Get.toNamed(Nav.logisticsFindDelivery);
                          },),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
