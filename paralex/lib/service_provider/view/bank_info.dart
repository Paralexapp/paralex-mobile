import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/custom_text_form_field.dart';
import '../../reusables/back_button.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';
import 'package:dotted_border/dotted_border.dart';
import '../controllers/bank_info_controller.dart';

class BankInfo extends StatelessWidget {
  BankInfo({super.key});

  final BankInfoController controller = Get.put(BankInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
        leading: IconButton(onPressed: Get.back, icon: PinkButton.backButton),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bank Info",
                  style: FontStyles.headingText.copyWith(
                    color: PaintColors.paralexpurple,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                Text("BVN no", style: _labelStyle()),
                CustomTextFormField(
                  hintText: "BVN no",
                  keyboardType: TextInputType.number,
                  controller: controller.bvnController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "BVN is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Text("NIN", style: _labelStyle()),
                CustomTextFormField(
                  hintText: "NIN",
                  keyboardType: TextInputType.number,
                  controller: controller.ninController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "NIN is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Text("Select bank", style: _labelStyle()),
                CustomTextFormField(
                  hintText: "Select Bank",
                  controller: controller.bankController,
                  readonly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bank selection is required";
                    }
                    return null;
                  },
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                  ontap: () async {
                    final bank = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Select Bank"),
                          content: SizedBox(
                            height: 300,
                            child: SingleChildScrollView(
                              child: Column(
                                children: controller.banks
                                    .map((bank) => RadioListTile<String>(
                                          title: Text(bank),
                                          value: bank,
                                          groupValue:
                                              controller.bankController.text,
                                          onChanged: (value) {
                                            Navigator.pop(context, value);
                                          },
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    if (bank != null) {
                      controller.bankController.text = bank;
                    }
                  },
                ),
                const SizedBox(height: 15),
                Text("Account number", style: _labelStyle()),
                CustomTextFormField(
                  hintText: "0737906787",
                  keyboardType: TextInputType.number,
                  controller: controller.accountNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Account number is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Text("Upload passport", style: _labelStyle()),
                const SizedBox(height: 15),
                Center(
                  child: GestureDetector(
                    onTap: controller.passportImage.value == null
                        ? controller.pickImage
                        : null,
                    child: SizedBox(
                      height: 113,
                      child: DottedBorder(
                        color: Colors.grey,
                        strokeWidth: 1,
                        dashPattern: [6, 4],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(8),
                        child: Stack(
                          children: [
                            Center(
                              child: Obx(() {
                                return controller.passportImage.value == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.insert_drive_file,
                                            color: Colors.grey[400],
                                            size: 50,
                                          ),
                                          const SizedBox(height: 10),
                                          Text('Upload File',
                                              style: _fileUploadStyle()),
                                          Text('Supports Jpg',
                                              style: _hintTextStyle()),
                                        ],
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          controller.passportImage.value!,
                                          fit: BoxFit.cover,
                                          height: double.infinity,
                                        ),
                                      );
                              }),
                            ),
                            Obx(() {
                              return controller.passportImage.value != null
                                  ? Positioned(
                                      bottom: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: controller.removeImage,
                                        child: _deleteIcon(),
                                      ),
                                    )
                                  : SizedBox.shrink();
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                CustomButton(
                  desiredWidth: 0.85,
                  buttonText: "SUBMIT",
                  buttonColor: PaintColors.paralexpurple,
                  ontap: controller.submitForm,
                ),
                const SizedBox(height: 20),
                _termsText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _labelStyle() => FontStyles.smallCapsIntro
      .copyWith(letterSpacing: 0, color: Color(0xFF868686), fontSize: 15);

  TextStyle _fileUploadStyle() => FontStyles.smallCapsIntro.copyWith(
      letterSpacing: 0,
      color: PaintColors.paralexpurple,
      fontSize: 12,
      fontWeight: FontWeight.bold);

  TextStyle _hintTextStyle() => FontStyles.smallCapsIntro
      .copyWith(letterSpacing: 0, color: Color(0xFF999999), fontSize: 10);

  Widget _deleteIcon() => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      );

  Widget _termsText() => Center(
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
                      color: PaintColors.paralexpurple,
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
      );
}
