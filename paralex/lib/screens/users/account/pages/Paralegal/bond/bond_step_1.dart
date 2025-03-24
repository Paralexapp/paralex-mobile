import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/service_provider/controllers/bail_bond_service_controller.dart';
import 'package:paralex/utils/validator.dart';

import '../../../../../../service_provider/view/widgets/custom_button.dart';
import '../../../../../../widgets/textfieldWidget.dart';

class BondFirstStep extends StatelessWidget {
  final BailBondServiceController controller = Get.put(BailBondServiceController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BondFirstStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PaintColors.bgColor,
        appBar: AppBar(
          title: Text(
            "Bail Bond Application Form",
            style: FontStyles.headingText
                .copyWith(color: PaintColors.paralexpurple, fontSize: 14),
          ),
          backgroundColor: PaintColors.bgColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Container(
            child: Column(
              children: [
                Text(
                  "You, the undersigned Defendant (\"defendant\" or \"you\" includes an accused person or a suspect), hereby represent and warrant that the following declarations made and answers given are true, complete and correct, and are made for the purpose of inducing Paralex Logistics Limited (\"surety\") to issue, or cause to be issued, bail bond(s) or undertaking(s) for you (singularly or collectively the \"Bond\"), in the total amount of.",
                  textAlign: TextAlign.justify, // Optional: Text alignment
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0, color: PaintColors.generalTextsm, fontSize: 12),
                  maxLines: 10, // Optional: Number of lines
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextfieldWidget(
                        controller: controller.chargeAmount,
                        keyboardType: TextInputType.number,
                        formatters: [FilteringTextInputFormatter.digitsOnly],
                        hintText: 'Enter bond amount',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      Obx(() {
                        return TextfieldWidget(
                          controller: controller.discountAmount,
                          hintText: '10% Bail-bond fee',
                          readOnly: true,
                          fillColor:
                              controller.changeFilColor.value ? Color(0xFFD265C3) : null,
                          textStyle: TextStyle(
                              color: controller.changeFilColor.value
                                  ? PaintColors.white
                                  : Colors.grey),
                          formatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                        );
                      }),
                      TextfieldWidget(
                          controller: controller.legalFirmName,
                          hintText: 'Court',
                          // validator: (value) => Validators.minLength(value, 3)
                      ),
                      TextfieldWidget(
                        controller: controller.investigatingAgency,
                        hintText: 'Investigating agency',
                        // validator: (value) => Validators.minLength(value, 3),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                          desiredWidth: 90,
                          buttonText: "Next",
                          buttonColor: PaintColors.paralexpurple,
                          ontap: () {
                            if (!_formKey.currentState!.validate()) return;
                            controller.navigateToBondStep2();
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
