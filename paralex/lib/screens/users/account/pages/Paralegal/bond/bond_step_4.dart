import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import '../../../../../../service_provider/view/widgets/date_picker.dart';
import 'package:paralex/service_provider/view/signup_screens/widgets/textfieldWidget.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/radion_btns.dart';

class BondFourthStep extends StatelessWidget {
  const BondFourthStep({super.key});

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
                  child: Column(
                    children: [
                      ReusableDatePicker(
                        controller: dateController,
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
                      // ReusableRadioButtons(
                      //   label: "   Gender",
                      //   options: const ['M', 'F'],
                      //   initialValue: 'M',
                      //   onChanged: (value) {},
                      // ),
                      const TextfieldWidget(
                        hintText: 'Arresting agency',
                        keyboardType: TextInputType.number,
                      ),
                      const TextfieldWidget(
                        hintText: 'Dentention facility location',
                      ),
                      const TextfieldWidget(
                        hintText: 'Charges',
                      ),
                      ReusableRadioButtons(
                        label: " Do you have an existing bond",
                        options: const ['Yes', 'No'],
                        initialValue: 'Yes',
                        onChanged: (value) {},
                      ),
                      const TextfieldWidget(
                        hintText: 'Pendin charges',
                      ),
                      const TextfieldWidget(
                        hintText: 'Details of Bond',
                      ),

                      CustomButton(
                          desiredWidth: 90,
                          buttonText: "Next",
                          buttonColor: PaintColors.paralexpurple,
                          ontap: () => Get.toNamed(Nav.bondStepE))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
