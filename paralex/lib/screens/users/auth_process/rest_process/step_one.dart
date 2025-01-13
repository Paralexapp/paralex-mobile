import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import '../../../../routes/navs.dart';
import '../../../../service_provider/controllers/user_choice_controller.dart';
import '../../../../service_provider/services/api_service.dart';

final userController = Get.find<UserChoiceController>();

class StepOne extends StatefulWidget {
  const StepOne({super.key});

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  final ApiService _apiService = ApiService();
  bool _isFormValid = false;
  bool _loading = false;

  bool isEmailValid(String email) {
    return EmailValidator.validate(email);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trouble with \nlogging in",
                style: FontStyles.headingText.copyWith(
                    color: PaintColors.paralexpurple,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Enter your email address and we'll send you\ninstructions to reset your password.",
                style: FontStyles.smallCapsIntro.copyWith(
                    color: PaintColors.generalTextsm, letterSpacing: 0),
              ),
              Form(
                key: _key,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter a value";
                          }
                          if (!isEmailValid(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          updateFormValidity();
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: 'you@email.com',
                          labelText: 'Email *',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: PaintColors.paralexpurple)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _loading ? null : _handleContinue,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: _isFormValid
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateFormValidity() {
    setState(() {
      _isFormValid = _emailController.text.isNotEmpty;
    });
  }

  Future<void> _handleContinue() async {
    if (!_key.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    userController.email.value = _emailController.text.trim();

    try {
      final endpoint =
          'api/v1/auth/initiate-password-reset?email=${Uri.encodeComponent(_emailController.text.trim())}';
      final response = await _apiService.postRequest(
        endpoint,
        {},
      );

      if (response.containsKey('token')) {
        userController.resetToken.value = response['token'];
        debugPrint('Token saved: ${userController.resetToken.value}');
      } else {
        throw Exception('Token not found in response');
      }
      Get.snackbar(
        'Success',
        'OTP sent to your email!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.toNamed(Nav.resetPassOtp);
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
}
