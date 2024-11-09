import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/back_button.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/service_provider/view/widgets/custom_button.dart';
import 'package:paralax/service_provider/view/widgets/custom_text_form_field.dart';
import '../../../reusables/fonts.dart';
import '../../../routes/navs.dart';
import '../../controllers/about_you_contd_controller.dart';

class AboutYouContd extends StatelessWidget {
  final AboutYouContdController controller = Get.put(AboutYouContdController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
        leading: IconButton(onPressed: Get.back, icon: PinkButton.backButton),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Do you have a bike?",
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: Color(0xFF868686),
                      fontSize: 15),
                ),
                Obx(() => Transform.translate(
                  offset: Offset(-12, 0),
                  child: Row(
                    children: [
                      BikeCheckbox(
                        label: "Yes",
                        value: true,
                        groupValue: controller.hasBike.value,
                        onChanged: (value) => controller.hasBike(value),
                      ),
                      SizedBox(width: 10),
                      BikeCheckbox(
                        label: "No",
                        value: false,
                        groupValue: controller.hasBike.value,
                        onChanged: (value) => controller.hasBike(value),
                      ),
                    ],
                  ),
                )),
                SizedBox(height: 15),
                buildCustomFormField(
                    "Number of bike?", "12",controller.bikeNumber, controller,),
                buildCustomFormField("Bike type", "Qlink",controller.bikeType, controller),
                buildCustomFormField("Bike Capacity","Bike capacity", controller.bikeCapacity, controller),
                buildCustomFormField("Chasis number","Chasis number", controller.chasisNumber, controller),
                SizedBox(height: size.height * 0.16),
                CustomButton(
                  desiredWidth: 0.85,
                  buttonText: "CONTINUE",
                  buttonColor: PaintColors.paralaxpurple,
                  ontap: () {
                    if (controller.hasBike.isTrue && controller.validateForm()) {
                      Get.toNamed(Nav.guarantorDetail);
                    }else if(controller.hasBike.isFalse){
                      Get.toNamed(Nav.guarantorDetail);
                    }
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "By clicking continue you agree to our ",
                            style: FontStyles.smallCapsIntro.copyWith(
                                letterSpacing: 0,
                                color: PaintColors.generalTextsm,
                                fontSize: 14),
                          ),
                          Text(
                            "Terms of ",
                            style: FontStyles.smallCapsIntro.copyWith(
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                color: PaintColors.paralaxpurple,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Service"),
                          SizedBox(width: 5),
                          Text("and"),
                          SizedBox(width: 5),
                          Text("Privacy policy "),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCustomFormField(String label, String hint, TextEditingController controller, AboutYouContdController ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
          label,
          style: FontStyles.smallCapsIntro.copyWith(
              letterSpacing: 0,
              color: AboutYouContdController.hasBike.value
                  ? Color(0xFF868686)
                  : Color(0x70868686),
              fontSize: 15),
        ),),
        Obx(() => CustomTextFormField(
          hintText: hint,
          enabled: AboutYouContdController.hasBike.value,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter $label";
            }
            return null;
          },
        )),
        SizedBox(height: 15),
      ],
    );
  }
}

class BikeCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final bool groupValue;
  final ValueChanged<bool> onChanged;

  const BikeCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: groupValue == value,
          onChanged: (bool? newValue) => onChanged(value),
          activeColor: Color(0xFF35124E),
          checkColor: Color(0xFF35124E),
        ),
        Text(label),
      ],
    );
  }
}
