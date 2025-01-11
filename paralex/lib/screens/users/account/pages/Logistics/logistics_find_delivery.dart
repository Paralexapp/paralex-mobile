import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_button.dart';
import 'package:paralex/screens/users/account/pages/controllers/logistics_delivery_info_controller.dart';

import 'widgets/logistics_textfield.dart';

class LogisticsFindDelivery extends StatefulWidget {
  final String? fromLocation;
  final String? toDestination;
  final String? orderDetails;
  final String? fare;
  LogisticsFindDelivery(
      {super.key, this.fromLocation, this.toDestination, this.orderDetails, this.fare});

  @override
  State<LogisticsFindDelivery> createState() => _LogisticsFindDeliveryState();
}

class _LogisticsFindDeliveryState extends State<LogisticsFindDelivery> {
  final LogisticsDeliveryInfoController _controller =
      Get.put(LogisticsDeliveryInfoController());

  final _formKey = GlobalKey<FormState>();

  final fromLocationController = TextEditingController();

  final toDestinationController = TextEditingController();

  final orderDetailsController = TextEditingController();

  final fareController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fromLocationController.text = widget.fromLocation ?? '';

    toDestinationController.text = widget.toDestination ?? '';
    orderDetailsController.text = widget.orderDetails ?? '';
    fareController.text = widget.fare ?? '';
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
                  height: 7.0,
                ),
                LogisticsCancelButton(),
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
                height: deviceHeight(context) * 0.55,
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
                          Row(
                            children: [
                              Icon(
                                Iconsax.lamp_charge,
                                color: PaintColors.paralexpurple,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Courier delivery',
                                style: FontStyles.bodyText1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          LogisticsTextfield(
                            controller: fromLocationController,
                            showPrefixIcon: true,
                            readOnly: true,
                            borderColor: PaintColors.textFieldBorderColor,
                            hintText: 'From',
                            icon: Iconsax.location,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          LogisticsTextfield(
                            controller: toDestinationController,
                            showPrefixIcon: true,
                            readOnly: true,
                            borderColor: PaintColors.textFieldBorderColor,
                            hintText: 'To',
                            icon: Iconsax.gps,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          LogisticsTextfield(
                            controller: orderDetailsController,
                            showPrefixIcon: true,
                            readOnly: true,
                            borderColor: PaintColors.textFieldBorderColor,
                            hintText: 'Order details',
                            icon: Iconsax.d_rotate,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          LogisticsTextfield(
                            controller: fareController,
                            borderColor: PaintColors.textFieldBorderColor,
                            showPrefixIcon: true,
                            readOnly: true,
                            hintText: 'Fare',
                            icon: Iconsax.moneys,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          LogisticsButton(
                            text: 'PROCEED TO PAYMENT',
                            // check: _formKey.currentState!.validate(),
                            onTap: () {
                              _controller.initializePayment(widget.fare ?? '0');
                              // Get.toNamed(Nav.logisticsPaymentMethod);
                            },
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
