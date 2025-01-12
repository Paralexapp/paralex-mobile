import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';
import 'package:paralex/screens/users/account/pages/controllers/logistics_delivery_info_controller.dart';
import '../../../../../service_provider/controllers/user_choice_controller.dart';
import '../../../../../service_provider/models/driver_model.dart';
import 'widgets/logistics_button.dart';
import 'widgets/logistics_textfield.dart';

class LogisticsHome extends StatefulWidget {
  const LogisticsHome({super.key});

  @override
  State<LogisticsHome> createState() => _LogisticsHomeState();
}

class _LogisticsHomeState extends State<LogisticsHome> {
  final userController = Get.find<UserChoiceController>();
  final LogisticsDeliveryInfoController _controller =
      Get.put(LogisticsDeliveryInfoController());
  final _formKey = GlobalKey<FormState>();

  var senderStreetController = TextEditingController();
  var senderEntransController = TextEditingController();
  var senderEntryphoneController = TextEditingController();
  var senderPhoneNumberController = TextEditingController();
  var receiverStreetController = TextEditingController();
  var receiverEntransController = TextEditingController();
  var receiverEntryphoneController = TextEditingController();
  var receiverPhoneNumberController = TextEditingController();
  var receiverNameController = TextEditingController();
  var whatToDeliverController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void requestDelivery() async {
    if (!_formKey.currentState!.validate()) return;

    _controller.senderStreetController.value = senderStreetController.text;
    _controller.senderEntransController.value = senderEntransController.text;
    _controller.senderEntryphoneController.value = senderEntryphoneController.text;
    _controller.senderPhoneNumberController.value = senderPhoneNumberController.text;
    _controller.receiverStreetController.value = receiverStreetController.text;
    _controller.receiverEntransController.value = receiverEntransController.text;
    _controller.receiverEntryphoneController.value = receiverEntryphoneController.text;
    _controller.receiverPhoneNumberController.value = receiverPhoneNumberController.text;
    _controller.receiverNameController.value = receiverNameController.text;
    _controller.whatToDeliverController.value = whatToDeliverController.text;

    var response = await _controller.getDeliveryAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  height: deviceHeight(context) * 0.45,
                  width: deviceWidth(context),
                  child: Image.asset(
                    'assets/images/map.jpg',
                    fit: BoxFit.cover,
                  ),
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
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 25, right: 25, bottom: 0),
                    child: Form(
                      key: _formKey,
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
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Order details',
                            style: FontStyles.bodyText1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Where to pick up',
                                style: FontStyles.bodyText1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: deviceWidth(context),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: deviceWidth(context) * 0.88,
                                  child: LogisticsTextfield(
                                    controller: senderStreetController,
                                    hintText: 'Street',
                                  ),
                                ),
                                // SizedBox(width: 8),
                                // SizedBox(
                                //   width: deviceWidth(context) * 0.25,
                                //   child: LogisticsTextfield(
                                //     controller: senderEntransController,
                                //     hintText: 'Entran...',
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          // LogisticsTextfield(
                          //   controller: senderEntryphoneController,
                          //   hintText: 'Floor, apartment, entryphone',
                          // ),
                          SizedBox(
                            height: 8,
                          ),
                          LogisticsPhoneField(
                            controller: senderPhoneNumberController,
                            hintText: 'Sender phone number',
                            suffixWidget: InkWell(
                              onTap: () {},
                              child: Icon(
                                Iconsax.call,
                                color: PaintColors.paralexpurple,
                              ),
                            ),
                            validator: (value) {
                              if (value!.number.isEmpty) {
                                return "Require";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Where to deliver',
                                style: FontStyles.bodyText1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          LogisticsTextfield(
                            controller: receiverNameController,
                            hintText: 'Enter Recipient Name',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: deviceWidth(context),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: deviceWidth(context) * 0.88,
                                  child: LogisticsTextfield(
                                    controller: receiverStreetController,
                                    hintText: 'Street',
                                  ),
                                ),
                                // SizedBox(width: 8),
                                Spacer(),
                                // SizedBox(
                                //   width: deviceWidth(context) * 0.25,
                                //   child: LogisticsTextfield(
                                //     controller: receiverEntransController,
                                //     hintText: 'Entran...',
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // LogisticsTextfield(
                          //   controller: receiverEntryphoneController,
                          //   hintText: 'Floor, apartment, entryphone',
                          // ),
                          SizedBox(
                            height: 8,
                          ),
                          // LogisticsTextfield(
                          //   hintText: 'Recipient phone number',
                          //   suffix: InkWell(
                          //     onTap: (){},
                          //     child: Icon(Iconsax.call, color: PaintColors.paralexpurple,),
                          //   ),
                          //   // suffixIcon: Iconsax.call,
                          //   // showSuffixIcon: true,
                          // ),
                          // SizedBox(height: 8,),
                          LogisticsPhoneField(
                            controller: receiverPhoneNumberController,
                            hintText: 'Recipient phone number',
                            onChanged: (val) {
                              print(val.number);
                              print(val.completeNumber);
                            },
                            suffixWidget: InkWell(
                              onTap: () {},
                              child: Icon(
                                Iconsax.call,
                                color: PaintColors.paralexpurple,
                              ),
                            ),
                            validator: (value) {
                              if (value!.number.isEmpty) {
                                return "Require";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'What to deliver',
                                style: FontStyles.bodyText1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          LogisticsTextfield(
                            controller: whatToDeliverController,
                            hintText:
                                'Example: Medium-sized box with legal documents that weight 5kg',
                            maxLines: 4,
                            minLines: 4,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Obx(() {
                            return LogisticsButton(
                              isLoading: _controller.isLoading.value,
                              text: 'SAVE',
                              check: false,
                              onTap: () {
                                requestDelivery();
                              },
                            );
                          }),
                          SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
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
