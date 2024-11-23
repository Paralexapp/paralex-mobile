import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_button.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_textfield.dart';

class LogisticsPaymentMethod2 extends StatelessWidget {
  const LogisticsPaymentMethod2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
            height: deviceHeight(context),
            width: deviceWidth(context),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 7.0,),
                child: Container(
                  color: PaintColors.paralexGreyShade1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,),
                          child: LogisticsCloseButton(
                            text: 'Add Card',
                            icon:  Icon(
                              Icons.close_rounded,
                              color: PaintColors.paralexTextColor1,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Text('CARD HOLDER NAME', style: FontStyles.cancelTextStyle.copyWith(
                              color: Color(0xFFA0A5BA),
                              fontSize: 14,
                            ),),
                          ],
                        ),
                        SizedBox(height: 8,),
                        LogisticsTextfield(
                          hintText: 'Your name',
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text('CARD NUMBER', style: FontStyles.cancelTextStyle.copyWith(
                              color: Color(0xFFA0A5BA),
                              fontSize: 14,
                            ),),
                          ],
                        ),
                        SizedBox(height: 8,),
                        LogisticsTextfield(
                          keyboardType: TextInputType.number,
                          hintText: '2134 _ _ _ _  _ _ _ _',
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: deviceWidth(context),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('EXPIRE DATE',style: FontStyles.cancelTextStyle.copyWith(
                                      color: Color(0xFFA0A5BA),
                                      fontSize: 14,
                                    ),),
                                    SizedBox(height: 8,),
                                    LogisticsTextfield(
                                      keyboardType: TextInputType.number,
                                      hintText: 'mm/yyyy',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('CVV', style: FontStyles.cancelTextStyle.copyWith(
                                      color: Color(0xFFA0A5BA),
                                      fontSize: 14,
                                    ),),
                                    SizedBox(height: 8,),
                                    LogisticsTextfield(
                                      keyboardType: TextInputType.number,
                                      hintText: '***',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: deviceHeight(context) * 0.4),
                        // Spacer(),
                        LogisticsButton(text: 'ADD & MAKE PAYMENT',
                          onTap: (){
                            Get.toNamed(Nav.logisticsPaymentMethod3);
                          },),
                        SizedBox(height: 35,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}