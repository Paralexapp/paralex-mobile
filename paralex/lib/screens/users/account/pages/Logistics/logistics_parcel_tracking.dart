import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';
import 'package:paralex/routes/navs.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_button.dart';

class LogisticsParcelTracking extends StatelessWidget {
  const LogisticsParcelTracking({super.key});

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
                SizedBox(height: 7.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        // Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0,bottom: 8.0,top: 5),
                        child: Text('Hide', style: FontStyles.cancelTextStyle),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0,bottom: 8.0,top: 5),
                        child: Text('Cancel', style: FontStyles.cancelTextStyle),
                      ),
                    ),
                  ],),
                Container(
                  height: deviceHeight(context) * 0.85,
                  width: deviceWidth(context),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/map.jpg'), fit: BoxFit.cover)
                  ),
                  child: Center(
                      child: Image.asset('assets/images/routeplan.png', fit: BoxFit.fitHeight,height: deviceHeight(context) * 0.65,)),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: deviceHeight(context) * 0.75,
                width: deviceWidth(context),
                decoration: BoxDecoration(
                  color: PaintColors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      width: deviceWidth(context) * 0.2,
                      height: 5,
                      decoration: BoxDecoration(
                        color: PaintColors.paralexLightGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      height: deviceHeight(context) * 0.7,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Container(
                              //   width: deviceWidth(context) * 0.2,
                              //   height: 5,
                              //   decoration: BoxDecoration(
                              //     color: PaintColors.paralexLightGrey,
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              // ),
                              // SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: InkWell(
                                  onTap: (){
                                    log('Show bottom sheet');
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          padding: const EdgeInsets.only(top: 10.0, right: 25, left: 25, bottom: 25),
                                          height: deviceHeight(context) * 0.4,
                                          width: deviceWidth(context),
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
                                              Text(
                                                'Want to cancel your order?',
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(height: 25),
                                              LogisticsButton(text: 'CONTINUE SEARCHING',),
                                              SizedBox(height: 20),
                                              LogisticsButton(text: 'CHANGE ORDER',check: true,textColor: PaintColors.paralexpurple,),
                                              SizedBox(height: 20),
                                              LogisticsButton(text: 'CANCEL ORDER',check: true,textColor: PaintColors.paralexpurple,),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text('Parcel Tracking', style: FontStyles.cancelTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF21252C),
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 12,),
                              Divider(color: Color(0xFFF1F2F6),),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Tracking ID:', style: FontStyles.cancelTextStyle.copyWith(
                                      fontSize: 14,
                                      color: Color(0xFFBABFC5),
                                    ),),
                                    Row(
                                      children: [
                                        Text('#9R9G87R',style: FontStyles.cancelTextStyle.copyWith(
                                          color: Color(0xFF76889A),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                        SizedBox(width: 8,),
                                        Icon(Icons.copy_rounded, size: 18,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Divider(color: Color(0xFFF1F2F6),),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('From:',style: FontStyles.cancelTextStyle.copyWith(
                                          fontSize: 14,
                                          color: Color(0xFFBABFC5),
                                        ),),
                                        SizedBox(height: 5,),
                                        Text('1234 Elm Street \nSpringfield. IL 62701',style: FontStyles.cancelTextStyle.copyWith(
                                          color: Color(0xFF76889A),
                                          fontSize: 14,
                                        ),),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('To',style: FontStyles.cancelTextStyle.copyWith(
                                          fontSize: 14,
                                          color: Color(0xFFBABFC5),
                                        ),),
                                        SizedBox(height: 5,),
                                        Text('5678 Maple Avenue \nSeattle, WA 98101',style: FontStyles.cancelTextStyle.copyWith(
                                          color: Color(0xFF76889A),
                                          fontSize: 14,
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Divider(color: Color(0xFFF1F2F6),),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Recipient:',style: FontStyles.cancelTextStyle.copyWith(
                                      fontSize: 14,
                                      color: Color(0xFFBABFC5),
                                    ),),
                                    Text('Jonathan Anderson',style: FontStyles.cancelTextStyle.copyWith(
                                      color: Color(0xFF76889A),
                                      fontSize: 14,
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Divider(color: Color(0xFFF1F2F6),),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Est. Delivery:',style: FontStyles.cancelTextStyle.copyWith(
                                      fontSize: 14,
                                      color: Color(0xFFBABFC5),
                                    ),),
                                    Text('20 Sept 2023',style: FontStyles.cancelTextStyle.copyWith(
                                      color: Color(0xFF76889A),
                                      fontSize: 14,
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Divider(color: Color(0xFFF1F2F6),),
                              SizedBox(height: 15,),
                              Container(
                                width: deviceWidth(context),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24)),
                                  border: Border.symmetric(vertical: BorderSide(color: Color(0xFFE8E8E8)), horizontal: BorderSide(color: Color(0xFFE8E8E8))),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 52,
                                            height: 52,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                image: DecorationImage(image: AssetImage('assets/images/callperson.png',), fit: BoxFit.cover)
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            children: [
                                              Text('Lisabi', style: FontStyles.cancelTextStyle.copyWith(
                                                color: PaintColors.paralexTextColor1,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700
                                              ),),
                                              Text('Courier', style: FontStyles.cancelTextStyle.copyWith(
                                                color: Color(0xFFA0A5BA),
                                                fontSize: 14,
                                              ),),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(Nav.logisticsCall);
                                            },
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: PaintColors.paralexpurple,
                                              ),
                                              child: Icon(Iconsax.call_copy, color: PaintColors.white,size: 20,),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(Nav.logisticsChat);
                                            },
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
                                                border: Border.all(color: PaintColors.paralexpurple)
                      ,                                        ),
                                              child: Icon(Iconsax.message_2, color: PaintColors.paralexpurple, size: 20,),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 18,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Column(
                                  children: [
                                    ...steps.map((e){
                                      return Step(dateDay: e['dateDay'], dateMonth: e['dateMonth'], title: e['title'], description: e['description'], isActive: e['isActive'], isCompleted: e['isCompleted'],);
                                    }),
                                  ],
                                ),
                              ),
                              SizedBox(height: 35,),
                              // SizedBox(
                              //   height: 500,
                              //     child: OrderTrackingScreen()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}


class Step extends StatelessWidget {
  final String dateDay;
  final String dateMonth;
  final String title;
  final String description;
  final bool isCompleted;
  final bool isActive;

  const Step({
    super.key,
    required this.dateDay,
    required this.dateMonth,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Opacity(
              opacity: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 5,
                    width: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 3,),
                  Container(
                    height: 5,
                    width: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 3,),
                  Container(
                    height: 5,
                    width: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 3,),
                  Container(
                    height: 5,
                    width: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 3,),
                ],
              ),
            ),
            Text(dateDay, textAlign: TextAlign.center, style: FontStyles.cancelTextStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF76889A),
            ),),
            Text(dateMonth, textAlign: TextAlign.center, style: FontStyles.cancelTextStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF76889A),
            ),),
          ],
        ),
        SizedBox(width: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                 height: 5,
                 width: 1,
                 color: Colors.grey,
               ),
               SizedBox(height: 3,),
               Container(
                 height: 5,
                 width: 1,
                 color: Colors.grey,
               ),
               SizedBox(height: 3,),
               Container(
                 height: 5,
                 width: 1,
                 color: Colors.grey,
               ),
               SizedBox(height: 3,),
               Container(
                 height: 5,
                 width: 1,
                 color: Colors.grey,
               ),
               SizedBox(height: 3,),
             ],
           ),
            if( isActive == true && isCompleted == false)
              CircleAvatar(
              radius: 12,
              backgroundColor: isActive == true ? Colors.black : Colors.grey,
              child: Icon(
                Icons.check,
                size: 14,
                color: Colors.white,
              ),
            ),
            if(  isActive == true && isCompleted == true)
              CircleAvatar(
                radius: 12,
                backgroundColor: isActive == true ? Colors.green : Colors.grey,
                child: Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            // Container(
            //   height: 25,
            //   width: 1,
            //   color: Colors.grey,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 5,
                  width: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: 3,),
                Container(
                  height: 5,
                  width: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: 3,),
                Container(
                  height: 5,
                  width: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: 3,),
                Container(
                  height: 5,
                  width: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: 3,),
              ],
            ),
          ],
        ),
        SizedBox(width: 8,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 5,
                      width: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 3,),
                    Container(
                      height: 5,
                      width: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 3,),
                    Container(
                      height: 5,
                      width: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 3,),
                    Container(
                      height: 5,
                      width: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 3,),
                  ],
                ),
              ),
              Text(title, style: FontStyles.cancelTextStyle.copyWith(
                color: isActive == true && isCompleted == true ? Colors.green : Color(0xFF21252C),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),),
              SizedBox(height: 4),
              Text(description,style: FontStyles.cancelTextStyle.copyWith(
                fontSize: 14,
                color: Color(0xFF76889A),
              ),),
            ],
          ),
        ),
      ],
    );
  }
}



final List<Map<String, dynamic>> steps = [
  {
    'dateDay': '17',
    'dateMonth': 'Sept',
    'title': 'Order placed',
    'description':
    'Order has been placed for delivery. A delivery personnel has been assigned.',
    'isActive': true,
    'isCompleted': false,
  },
  {
    'dateDay': '18',
    'dateMonth': 'Sept',
    'title': 'Pickup Confirmation',
    'description': 'Our delivery man picked up the parcel from us.',
    'isActive': true,
    'isCompleted': false,
  },
  {
    'dateDay': '19',
    'dateMonth': 'Sept',
    'title': 'In-Transit',
    'description':
    'The package is now in transit. You will receive the parcel shortly.',
    'isActive': true,
    'isCompleted': false,
  },
  {
    'dateDay': '20',
    'dateMonth': 'Sept',
    'title': 'Successfully Delivered',
    'description':
    'Your parcel was delivered successfully by the delivery man.',
    'isCompleted': true,
    'isActive': true,
  },
];




