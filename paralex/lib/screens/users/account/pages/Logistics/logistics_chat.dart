import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_button.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_textfield.dart';

class LogisticsChat extends StatelessWidget {
  const LogisticsChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 45.0, left: 25, right: 25, bottom: 25),
          child: Column(
            children: [
              LogisticsCloseButton(
                text: 'Lisabi',
                icon: Icon(
                  Icons.close_rounded,
                  color: PaintColors.paralexTextColor1,
                  size: 20,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                        UserChatBox(
                          message: 'Are you coming?',
                          time: '8:10 pm',
                          isItUser: true,
                        ),
                        UserChatBox(
                          message: 'Hay, Congratulation for order',
                          time: '8:11 pm',
                          isItUser: false,
                        ),
                        UserChatBox(
                          message: 'Hey Where are you now?',
                          time: '8:11 pm',
                          isItUser: true,
                        ),
                        UserChatBox(
                          isItUser: false,
                          message: 'I\'m coming, just   wait...',
                          time: '8:12 pm',
                        ),
                        UserChatBox(
                          isItUser: true,
                          message: 'Hurry Up, Man',
                          time: '8:12 pm',
                        ),
                        UserChatBox(
                          isItUser: false,
                          message: 'I\'m coming by 4pm tomorrow',
                          time: '8:13 pm',
                        ),
                        UserChatBox(
                          isItUser: true,
                          message: 'Lover boy',
                          time: '8:15 pm',
                        ),
                        UserChatBox(
                          isItUser: false,
                          message: 'Just wait for her...',
                          time: '8:16 pm',
                        ),
                        UserChatBox(
                          isItUser: true,
                          message: 'Hurry Up, Man',
                          time: '8:17 pm',
                        ),
                        UserChatBox(
                          isItUser: false,
                          message: 'I\'m no longer coming today',
                          time: '8:17 pm',
                        ),
                        UserChatBox(
                          isItUser: true,
                          message: 'One love bruh',
                          time: '8:18 pm',
                        ),
                        UserChatBox(
                          isItUser: false,
                          message: 'How are doing today?',
                          time: '8:19 pm',
                        ),
                        UserChatBox(
                          isItUser: true,
                          message: 'Yoh, my man',
                          time: '8:20 pm',
                        ),
                  ],
                ),
              ),
              // SizedBox(height: 10,),
              LogisticsTextfield(
                padding: EdgeInsets.symmetric(vertical: 10),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                hintText: 'Write somethings',
                prefix: Icon(
                  Icons.emoji_emotions_outlined,
                  color: PaintColors.bodyText1Color,
                ),
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: PaintColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.send_2,
                      color: PaintColors.paralexpurple,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserChatBox extends StatelessWidget {
  const UserChatBox({super.key, this.message, this.time, required this.isItUser});
  final String? message;
  final String? time;
  final bool isItUser;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isItUser == false ? Alignment.centerRight : Alignment.centerLeft,
      child: isItUser == false ? SizedBox(
        // width: deviceWidth(context) * 0.75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                            color: Color(0XFF98A8B8), shape: BoxShape.circle),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          time.toString(),
                          style: FontStyles.cancelTextStyle.copyWith(
                            color: Color(0XFFABABAB),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFFF0F5FA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message.toString(),
                            style: FontStyles.cancelTextStyle.copyWith(
                              fontSize: 14,
                              color: Color(0xFF32343E),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 18),
              ],
            ),
          ],
        ),
      ) :
      SizedBox(
        // width: deviceWidth(context) * 0.75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Opacity(
                        opacity: 0,
                        child: Icon(
                          Icons.check,
                          color: PaintColors.paralexpurple,
                          size: 16,
                        )),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      time.toString(),
                      style: FontStyles.cancelTextStyle.copyWith(
                        color: Color(0XFFABABAB),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: PaintColors.paralexpurple,
                      size: 16,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: PaintColors.paralexpurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message.toString(),
                          style: FontStyles.cancelTextStyle.copyWith(
                            fontSize: 14,
                            color: PaintColors.white,
                          ),
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7BFEF), shape: BoxShape.circle),
                    )
                  ],
                ),
                SizedBox(height: 18),
              ],
            ),
          ],
        ),
      )
    );
  }
}

// class OtherUserChatBox extends StatelessWidget {
//   const OtherUserChatBox({super.key, this.message, this.time});
//   final String? message;
//   final String? time;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 2.0),
//                 child: Container(
//                   height: 36,
//                   width: 36,
//                   decoration: BoxDecoration(
//                       color: Color(0XFF98A8B8), shape: BoxShape.circle),
//                 ),
//               ),
//               SizedBox(
//                 width: 8,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     time.toString(),
//                     style: FontStyles.cancelTextStyle.copyWith(
//                       color: Color(0XFFABABAB),
//                       fontSize: 12,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 2,
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Color(0xFFF0F5FA),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       message.toString(),
//                       style: FontStyles.cancelTextStyle.copyWith(
//                         fontSize: 14,
//                         color: Color(0xFF32343E),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 18),
//         ],
//       ),
//     );
//   }
// }
