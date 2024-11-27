import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';
import 'package:paralex/routes/navs.dart';

class LogisticsCall extends StatelessWidget {
  const LogisticsCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF273f55),
                  ),
                  height: deviceHeight(context) * 0.65,
                  width: deviceWidth(context),
                  child: Center(child: Image.asset('assets/images/routeplan.png', fit: BoxFit.fitHeight,height: deviceHeight(context) * 0.45,)),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: deviceHeight(context) * 0.55,
                width: deviceWidth(context),
                decoration: BoxDecoration(
                  color: PaintColors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 25, right: 25, bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Container(
                       width: 90,
                       height: 90,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(25),
                         image: DecorationImage(image: AssetImage('assets/images/callperson.png',), fit: BoxFit.cover)
                       ),
                     ),
                     SizedBox(height: 10),
                     Text('Lisabi',style: FontStyles.cancelTextStyle.copyWith(
                       fontSize: 20,
                       fontWeight: FontWeight.w700,
                       color: PaintColors.paralexTextColor1,
                     ),),
                     Text('Connecting......', style: FontStyles.cancelTextStyle.copyWith(
                       fontSize: 18,
                       color: Color(0xFF979797),
                     ),),
                     Spacer(),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
                       child: SizedBox(
                         width: deviceWidth(context),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             InkWell(
                               onTap: () {},
                               child: Container(
                                 height: 45,
                                 width: 45,
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: PaintColors.paralexGreyShade2,
                                 ),
                                 child: Icon(Icons.mic_off_outlined),
                               ),
                             ),
                             Spacer(),
                             InkWell(
                               onTap: (){
                                 // Get.toNamed(Nav.logisticsChat);
                               },
                               child: Container(
                                 height: 105,
                                 width: 105,
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: PaintColors.paralexGreyShade2,
                                   image: DecorationImage(image: AssetImage('assets/images/endcall.png'), fit: BoxFit.cover)
                                 ),
                               ),
                             ),
                             Spacer(),
                             InkWell(
                               onTap: () {},
                               child: Container(
                                 height: 45,
                                 width: 45,
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: PaintColors.paralexGreyShade2,
                                 ),
                                 child: Icon(Icons.volume_up_outlined),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                     SizedBox(height: 35,),
                   ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
