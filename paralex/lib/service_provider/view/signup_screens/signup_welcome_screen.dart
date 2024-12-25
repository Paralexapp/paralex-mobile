import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/paints.dart';
import '../../../reusables/fonts.dart';
import '../../../reusables/back_button.dart';
import '../../controllers/signup_controller.dart';
import '../widgets/signupWidget.dart';

class SignupWelcomeScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  SignupWelcomeScreen({super.key});

  InputDecoration kInputDecoration(
      RxBool passwordVisible, VoidCallback toggleVisibility, String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: FontStyles.hintStyle,
      filled: true,
      fillColor: const Color(0xFFECF1F4),
      suffixIcon: IconButton(
        icon: Icon(passwordVisible.value
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined),
        onPressed: toggleVisibility,
      ),
      suffixIconColor: const Color(0xFF4C1044),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF4C1044), width: 2.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
        leading: IconButton(
          icon: PinkButton.backButton,
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to \nParalex",
                  style: FontStyles.headingText.copyWith(
                      color: PaintColors.paralexpurple,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "Committed to providing prompt,\nresponsive services ",
                  style: FontStyles.smallCapsIntro.copyWith(
                      color: PaintColors.generalTextsm, letterSpacing: 0),
                ),
                const SizedBox(height: 15),
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          onChanged: (value) {
                            controller.emailText.value = value;
                            controller.validateEmailField(value);
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email address',
                            hintStyle: FontStyles.hintStyle,
                            filled: true,
                            fillColor: const Color(0xFFECF1F4),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF4C1044), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        // Display email validation error if invalid
                        if (!controller.isEmailValid.value &&
                            controller.emailText.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Please enter a valid email address",
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                      ],
                    )),
                const SizedBox(height: 15),

                // Password Field with validation
                Obx(() => TextField(
                      controller: controller.passwordController,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        controller.passwordText.value = value;
                        controller.validatePassword(value);
                      },
                      obscureText: controller.passwordVisibility.value,
                      decoration: kInputDecoration(
                          controller.passwordVisibility,
                          controller.togglePasswordVisibility,
                          "Password"),
                    )),
                const SizedBox(height: 15),

                // Confirm Password Field
                Obx(() => TextField(
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) =>
                          controller.confirmPasswordText.value = value,
                      obscureText: controller.confirmPasswordVisibility.value,
                      decoration: kInputDecoration(
                          controller.confirmPasswordVisibility,
                          controller.toggleConfirmPasswordVisibility,
                          "Confirm Password"),
                    )),
                const SizedBox(height: 25),

                // Validation status display
                Obx(() => Row(
                      children: [
                        Icon(
                          controller.isMinLengthValid.value
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: controller.isMinLengthValid.value
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text("Minimum 8 characters",
                            style: FontStyles.smallCapsIntro.copyWith(
                                letterSpacing: 0,
                                color: const Color(0xFF4A4A68),
                                fontSize: 12)),
                      ],
                    )),
                Obx(() => Row(
                      children: [
                        Icon(
                          controller.isUpperCaseValid.value
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: controller.isUpperCaseValid.value
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text("One UPPERCASE Character",
                            style: FontStyles.smallCapsIntro.copyWith(
                                letterSpacing: 0,
                                color: const Color(0xFF4A4A68),
                                fontSize: 12)),
                      ],
                    )),
                Obx(() => Row(
                      children: [
                        Icon(
                          controller.isSpecialCharacterValid.value
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: controller.isSpecialCharacterValid.value
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text("One Unique Character (e.g: !@#\$%^&*?)",
                            style: FontStyles.smallCapsIntro.copyWith(
                                letterSpacing: 0,
                                color: const Color(0xFF4A4A68),
                                fontSize: 12)),
                      ],
                    )),
                const SizedBox(height: 25),

                // Continue Button
                Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: controller.isEmailValid.value &&
                              controller.isMinLengthValid.value &&
                              controller.isUpperCaseValid.value &&
                              controller.isSpecialCharacterValid.value &&
                              controller.passwordText.value ==
                                  controller.confirmPasswordText.value
                          ? PaintColors.paralexpurple
                          : const Color(0xFFFFEAF5),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (!controller.isEmailValid.value) {
                          Get.snackbar("Error", "Please enter a valid email");
                        } else if (controller.passwordText.value !=
                            controller.confirmPasswordText.value) {
                          Get.snackbar("Error", "Passwords do not match");
                        } else if (controller.isMinLengthValid.value &&
                            controller.isUpperCaseValid.value &&
                            controller.isSpecialCharacterValid.value) {
                          controller.signUp();
                        } else {
                          Get.snackbar("Error",
                              "Password does not meet all requirements");
                        }
                      },
                      child: Center(
                        child: controller.loading.value == true ? Container(
                          width: 30,
                          height: 30,
                          padding: const EdgeInsets.all(2.0),
                          child:
                          const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ) :
                        Text("CONTINUE",
                          style: FontStyles.smallCapsIntro.copyWith(
                            color: Colors.white,
                            letterSpacing: 0,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 98,
                      height: 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                          colors: [
                            Color(0x75D9D9D9),
                            Color(0xFFD9D9D9),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      "Or signup with",
                      style:
                          FontStyles.contentText.copyWith(color: Colors.black),
                    ),
                    const SizedBox(width: 7),
                    Container(
                      width: 98,
                      height: 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                          colors: [
                            Color(0xFFD9D9D9),
                            Color(0x75D9D9D9),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignupWidget(imgpath: "assets/images/Google.svg"),
                    SizedBox(width: 15),
                    SignupWidget(imgpath: "assets/images/apple.svg"),
                    SizedBox(width: 15),
                    SignupWidget(imgpath: "assets/images/fb.svg"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
