import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/service_provider/services/api_service.dart';

import '../../../service_provider/controllers/user_choice_controller.dart';

final userController = Get.find<UserChoiceController>();

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final ApiService _apiService = ApiService();
  final List<TextEditingController> _otpControllers =
  List.generate(4, (_) => TextEditingController());
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.15),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Header Section
                Column(
                  children: [
                    Text(
                      "Verification",
                      style: FontStyles.headingText.copyWith(
                        color: PaintColors.paralexpurple,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      "Enter the code we just sent",
                      style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.generalTextsm,
                        letterSpacing: 0,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "you on your email",
                      style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.generalTextsm,
                        letterSpacing: 0,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // OTP Input Section
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(4, (index) => SizedBox(
                            height: 68,
                            width: 68,
                            child: TextField(
                              controller: _otpControllers[index],
                              onChanged: (value) {
                                if (value.length == 1 && index < 3) {
                                  FocusScope.of(context).nextFocus(); // Move to next field
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context).previousFocus(); // Move to previous field
                                }
                              },
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),

                // Resend OTP Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code?",
                      style: FontStyles.smallCapsIntro.copyWith(
                        color: PaintColors.generalTextsm,
                        letterSpacing: 0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: resendOtp,
                      child: Text(
                        " Resend",
                        style: FontStyles.smallCapsIntro.copyWith(
                          color: PaintColors.paralexpurple,
                          letterSpacing: 0,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.1),

                // Continue Button
                Column(
                  children: [
                    GestureDetector(
                      onTap: _isLoading ? null : validateOtp,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: size.width * 0.85,
                        decoration: const BoxDecoration(
                          color: PaintColors.paralexpurple,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            "CONTINUE",
                            style: FontStyles.smallCapsIntro.copyWith(
                              color: Colors.white,
                              letterSpacing: 0,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to validate OTP
  Future<void> validateOtp() async {
    final otp = _otpControllers.map((c) => c.text).join(); // Combine OTP digits
    if (otp.length != 4) {
      Get.snackbar(
        'Error',
        'Please enter a valid 4-digit OTP.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _apiService.postRequest('validate-otp', {
        "otp": otp,
      });

      Get.snackbar(
        'Success',
        'OTP validated successfully!',
        snackPosition: SnackPosition.TOP,
      );
      if (userController.isUser.value) {
        Get.toNamed(
            Nav.tellusMoreforUsers); // Navigate to UserHomeScreen
      } else {
        Get.toNamed(Nav
            .selectServiceScreen); // Navigate to ServiceProviderHomeScreen
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to resend OTP
  Future<void> resendOtp() async {
    try {
      final response = await _apiService.postRequest('send-otp', {
        "email": userController.email.value,
      });

      Get.snackbar(
        'Success',
        'A new OTP has been sent to your email.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void dispose() {
    // Dispose OTP controllers
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}