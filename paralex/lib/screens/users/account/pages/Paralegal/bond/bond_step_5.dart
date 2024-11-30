import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';

import '../../../../../../service_provider/controllers/bail_bond_service_controller.dart';
import '../../../../../../utils/validator.dart';
import '../../../../../../widgets/textfieldWidget.dart';

class BondStepFive extends StatelessWidget {
  final BailBondServiceController controller = Get.put(BailBondServiceController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BondStepFive({super.key});

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
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("EMPLOYMENT"),
                    const SizedBox(
                      height: 10,
                    ),
                    TextfieldWidget(
                      controller: controller.occupation1,
                      hintText: 'Occupation 1',
                      keyboardType: TextInputType.text,
                      validator: (value) => Validators.minLength(value, 3),
                    ),
                    TextfieldWidget(
                      controller: controller.occupation2,
                      hintText: 'Occupation 2',
                      keyboardType: TextInputType.text,
                    ),
                    TextfieldWidget(
                      controller: controller.occupation3,
                      hintText: 'Occupation 3',
                      keyboardType: TextInputType.text,
                    ),
                    TextfieldWidget(
                      controller: controller.occupation4,
                      hintText: 'Occupation 4',
                      keyboardType: TextInputType.text,
                    ),
                    TextfieldWidget(
                      controller: controller.occupation5,
                      hintText: 'Occupation 5',
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextfieldWidget(
                      controller: controller.currentEmployerName,
                      hintText: 'Current employers name',
                      validator: (value) => Validators.minLength(value, 3),
                    ),
                    TextfieldWidget(
                      controller: controller.durationOfEmployment,
                      hintText: 'How long',
                      validator: (value) => Validators.minLength(value, 3),
                    ),
                    TextfieldWidget(
                      controller: controller.position,
                      hintText: 'Postiton',
                    ),
                    TextfieldWidget(
                      controller: controller.supervisorName,
                      hintText: 'Supervisors name',
                      validator: (value) => Validators.minLength(value, 3),
                    ),
                    TextfieldWidget(
                      controller: controller.supervisorWorkPhone,
                      hintText: 'Work phone',
                      keyboardType: TextInputType.text,
                      formatters: [LengthLimitingTextInputFormatter(11)],
                      validator: (value) => Validators.minLength(value, 11),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                        desiredWidth: 90,
                        buttonText: "SUBMIT",
                        buttonColor: PaintColors.paralexpurple,
                        ontap: () {
                          if (!_formKey.currentState!.validate()) return;
                          controller.summitBailBondDetails();
                        })
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
