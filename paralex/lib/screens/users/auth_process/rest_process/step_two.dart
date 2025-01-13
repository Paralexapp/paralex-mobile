import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import '../../../../service_provider/controllers/user_choice_controller.dart';
import '../../../../service_provider/services/api_service.dart';

final userController = Get.find<UserChoiceController>();

class StepTwo extends StatefulWidget {
  const StepTwo({super.key});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  final TextEditingController _digit1 = TextEditingController();
  final TextEditingController _digit2 = TextEditingController();
  final TextEditingController _digit3 = TextEditingController();
  final TextEditingController _digit4 = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isOtpComplete = false;
  bool _loading = false;

  String get _otp =>
      '${_digit1.text}${_digit2.text}${_digit3.text}${_digit4.text}';

  // Update the button state based on OTP input
  void _updateButtonState() {
    setState(() {
      _isOtpComplete = _digit1.text.isNotEmpty &&
          _digit2.text.isNotEmpty &&
          _digit3.text.isNotEmpty &&
          _digit4.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
      ),
      backgroundColor: PaintColors.bgColor,
      body: Container(
        margin: EdgeInsets.only(top: size.height * 0.03),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Confirm your\nemail address",
                  style: FontStyles.headingText.copyWith(
                      color: PaintColors.paralexpurple,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                Text(
                  "Enter the OTP sent to your email",
                  style: FontStyles.smallCapsIntro.copyWith(
                      color: PaintColors.generalTextsm,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Form(
              child: Row(
                children: [
                  _buildOtpField(_digit1),
                  const SizedBox(width: 20),
                  _buildOtpField(_digit2),
                  const SizedBox(width: 20),
                  _buildOtpField(_digit3),
                  const SizedBox(width: 20),
                  _buildOtpField(_digit4),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => resendOtp(),
              child: Text(
                "Resend code",
                style: FontStyles.smallCapsIntro.copyWith(
                    color: PaintColors.generalTextsm,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _isOtpComplete && !_loading ? _validateOtp : null,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: _isOtpComplete
                      ? PaintColors.paralexpurple
                      : PaintColors.fadedPinkBg,
                  foregroundColor: Colors.white,
                  minimumSize: Size(size.width * 0.90, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                label: Text(
                  "CONTINUE",
                  style: FontStyles.headingText.copyWith(fontSize: 20),
                ),
                icon: _loading
                    ? Container(
                        width: 30,
                        height: 30,
                        padding: const EdgeInsets.all(2.0),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Container(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField(TextEditingController controller) {
    return SizedBox(
      height: 68,
      width: 60,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          _updateButtonState();
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _validateOtp() async {
    setState(() {
      _loading = true; // Start loading
    });

    try {
      final response = await _apiService.postRequest(
        'api/v1/auth/validate-otp',
        {'otp': _otp},
      );

      if (response['status'] == 'ACCEPTED') {
        Get.snackbar(
          'Success',
          'OTP validated successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(Nav.setNewPass);
      } else {
        Get.snackbar(
          'Error',
          response['message'] ?? ' Invalid OTP!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> resendOtp() async {
    try {
      final response = await _apiService.postRequest('api/v1/auth/send-otp', {
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
}
