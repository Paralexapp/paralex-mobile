import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import '../../../../../../service_provider/controllers/bail_bond_service_controller.dart';
import '../../../../../../service_provider/view/widgets/date_picker.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/radion_btns.dart';

import '../../../../../../utils/validator.dart';
import '../../../../../../widgets/textfieldWidget.dart';

class BondFourthStep extends StatelessWidget {
  final BailBondServiceController controller = Get.put(BailBondServiceController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BondFourthStep({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
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
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ReusableDatePicker(
                        controller: controller.dateOfCurrentArrest,
                        labelText: "Date of current arrest",
                        onDateChanged: (date) {
                          // print('Selected date: $date');
                        },
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2025),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextfieldWidget(
                        controller: controller.arrestingAgency,
                        hintText: 'Arresting agency',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      TextfieldWidget(
                        controller: controller.detentionFacilityLocation,
                        hintText: 'Dentention facility location',
                      ),
                      TextfieldWidget(
                        controller: controller.charges,
                        hintText: 'Charges',
                        validator: (value) => Validators.minLength(value, 3),
                      ),
                      ReusableRadioButtons(
                        label: " Do you have an existing bond",
                        options: const ['Yes', 'No'],
                        initialValue: 'Yes',
                        onChanged: (value) {
                          if (value?.toLowerCase() == "yes") {
                            controller.existingBailBond(true);
                          } else {
                            controller.existingBailBond(false);
                          }
                        },
                      ),
                      TextfieldWidget(
                        controller: controller.pendingChargesInJurisdiction,
                        hintText: 'Pending charges',
                      ),
                      TextfieldWidget(
                        controller: controller.detailsOfBond,
                        hintText: 'Details of Bond',
                        validator: (val) {
                          return null;
                        },
                      ),
                      CustomButton(
                          desiredWidth: 90,
                          buttonText: "Next",
                          buttonColor: PaintColors.paralexpurple,
                          ontap: () {
                            if (!_formKey.currentState!.validate()) return;
                            controller.navigateToBondStep5();
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
