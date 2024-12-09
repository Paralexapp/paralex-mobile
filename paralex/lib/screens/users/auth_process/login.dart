import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/service_provider/controllers/auth_controller.dart';
import '../../../service_provider/controllers/user_choice_controller.dart';
import '../../../service_provider/services/api_service.dart';

final userController = Get.find<UserChoiceController>();

class LoginWithPassword extends StatefulWidget {
  const LoginWithPassword({super.key});

  @override
  State<LoginWithPassword> createState() => _LoginWithPasswordState();
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  final AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService(); // Instance of ApiService
  bool _isObscure = true;
  bool _hasEightChars = false;
  bool _hasCapitalLetters = false;
  bool _hasSpecialChar = false;
  bool loading = false;
  bool _isFormValid = false;

  bool isEmailValid(String email) {
    return EmailValidator.validate(email);
  }

  @override
  Widget build(BuildContext context) {
    userController.email.value = _emailController.text;
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
                  // Header Section
                  Column(
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
                        style: FontStyles.smallCapsIntro
                            .copyWith(color: PaintColors.generalTextsm, letterSpacing: 0),
                      )
                    ],
                  ),

                  // Form Section
                  Form(
                      key: _key,
                      child: Column(
                        children: [
                          // Email Field
                          const SizedBox(height: 20),
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
                                          BorderSide(color: PaintColors.paralexpurple))),
                            ),
                          ),
                          // Password Field
                          Container(
                              child: TextFormField(
                            obscureText: _isObscure,
                            onChanged: (value) {
                              setState(() {
                                _hasEightChars = value.length >= 8;
                                _hasCapitalLetters = RegExp(r'[A-Z]').hasMatch(value);
                                _hasSpecialChar =
                                    RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
                                updateFormValidity();
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a value";
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return 'Password must have at least one capital letter';
                              } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                  .hasMatch(value)) {
                                return 'Password must have at least one special character';
                              }
                              return null;
                            },
                            controller: _passwordController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                    icon: _isObscure
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                hintText: 'password',
                                labelText: 'password *',
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: PaintColors.paralexpurple))),
                          )),

                          // Password Validation Indicators
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              indicator(_hasEightChars, 'Minimum 8 Characters'),
                              const SizedBox(width: 10),
                              indicator(_hasCapitalLetters, 'One UPPERCASE Letter'),
                              const SizedBox(width: 10),
                              indicator(_hasSpecialChar,
                                  'One Unique Character (e.g: !@#%^&*?)'),
                            ],
                          ),
                          const SizedBox(height: 50),

                          // Submit Button
                          Center(
                              child: ElevatedButton.icon(
                                  onPressed: loading ? null : loginUser,
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: _isFormValid
                                          ? PaintColors.paralexpurple
                                          : PaintColors.fadedPinkBg,
                                      foregroundColor: Colors.white,
                                      minimumSize: Size(size.width * 0.90, 48),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8))),
                                  label: Text(
                                    loading ? "LOADING..." : "CONTINUE",
                                    style: FontStyles.headingText.copyWith(fontSize: 20),
                                  ),
                                  icon: loading
                                      ? Container(
                                          width: 30,
                                          height: 30,
                                          padding: const EdgeInsets.all(2.0),
                                          child: const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : Container()))
                        ],
                      )),
                ],
              )),
        ));
  }

  void updateFormValidity() {
    setState(() {
      _isFormValid = _hasEightChars &&
          _hasCapitalLetters &&
          _hasSpecialChar &&
          _passwordController.text.isNotEmpty &&
          _emailController.text.isNotEmpty;
    });
  }

  Widget indicator(bool isValid, String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isValid ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: FontStyles.smallCapsIntro.copyWith(
              color: PaintColors.generalTextsm,
              letterSpacing: 0,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Future<void> loginUser() async {
    if (!_key.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    final loginData = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    try {
      final response = await _apiService.postRequest('api/v1/auth/hlogin',
          {"email": _emailController.text, "password": _passwordController.text});

      final authToken = response['data'];

      _authController.token.value = authToken;

      userController.authToken.value = authToken; // Pass token to UserChoiceController

      // Fetch logged-in user data
      await userController.fetchLoggedInUser();

      Get.snackbar(
        'Success',
        'Login successful!',
        snackPosition: SnackPosition.TOP,
      );
      if (userController.isUser.value) {
        Get.toNamed(Nav.home);
      } else {
        Get.toNamed(Nav.selectServiceScreen);
      }
    } catch (e) {
      if (e is Exception) {
        String errorMessage = e.toString();
        if (errorMessage.contains("Account is yet to be verified")) {
          Get.snackbar(
            'Error',
            '$e.',
            snackPosition: SnackPosition.TOP,
          );
          await sendOtp();
          Get.toNamed(Nav.otpScreen, arguments: {
            'email': _emailController.text,
          });
        }
      }
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> sendOtp() async {
    try {
      final response = await _apiService.postRequest('api/v1/auth/send-otp', {
        "email": _emailController.text, // Include the email to send the OTP
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
      throw Exception('Failed to send OTP: $e');
    }
  }
}
