import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/date_picker.dart';

import '../../../../../../widgets/textfieldWidget.dart';

class ImmigrationStepTwo extends StatelessWidget {
  const ImmigrationStepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "IMMIGRATION",
            style: FontStyles.headingText
                .copyWith(color: PaintColors.paralexpurple, fontSize: 14),
          ),
        ),
        backgroundColor: PaintColors.bgColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ReusableDatePicker(
              controller: dateController,
              labelText: "Date of incoperation",
              onDateChanged: (date) {
                // print('Selected date: $date');
              },
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2025),
            ),
            SizedBox(
              height: 10,
            ),
            TextfieldWidget(
              // labelText: 'Full Name',
              hintText: 'Name of company',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            TextfieldWidget(
              // labelText: 'Full Name',
              hintText: 'Description of business activities',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            TextfieldWidget(
              // labelText: 'Full Name',
              hintText: 'Office address',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            TextfieldWidget(
              // labelText: 'Full Name',
              hintText: 'Email',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                ontap: () => Get.toNamed(Nav.bondSubmitted),
                desiredWidth: 90,
                buttonText: "Submit",
                buttonColor: PaintColors.paralexpurple)
          ],
        ),
      ),
    );
  }
}
