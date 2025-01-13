import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/date_picker.dart';
import 'package:paralex/service_provider/view/widgets/radion_btns.dart';

import '../../../../../../widgets/textfieldWidget.dart';

class TrademarkStepOne extends StatelessWidget {
  const TrademarkStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        title: Center(
          child: Text(
            "TRADEMARK",
            style: FontStyles.headingText
                .copyWith(color: PaintColors.paralexpurple, fontSize: 14),
          ),
        ),
        backgroundColor: PaintColors.bgColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'Full Name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'Nickname/Alias',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'Mobile Number',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'Current Home',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'Residence address',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'Email address',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'Duration of stay',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'Date of birth',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          ReusableDatePicker(
            controller: dateController,
            labelText: "Date of birth",
            onDateChanged: (date) {
              // print('Selected date: $date');
            },
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2025),
          ),
          ReusableRadioButtons(
            label: " Sex",
            options: const ['Male', 'Female'],
            initialValue: 'Yes',
            onChanged: (value) {},
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'Place of birth',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'Nationality',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'NIN',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          TextfieldWidget(
            // labelText: 'Full Name',
            hintText: 'International Passport Number',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
              desiredWidth: 90,
              ontap: () => Get.toNamed(Nav.trademarkStepTwo),
              buttonText: "Next",
              buttonColor: PaintColors.paralexpurple)
        ]),
      ),
    );
  }
}
