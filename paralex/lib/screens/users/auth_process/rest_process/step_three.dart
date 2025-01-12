import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';

import '../../../../routes/navs.dart';
import '../../../../service_provider/controllers/user_choice_controller.dart';
import '../../../../service_provider/services/api_service.dart';

final userController = Get.find<UserChoiceController>();
class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ApiService _apiService = ApiService();

  bool _isObscure = false;
  bool _isObscure1 = false;
  bool _hasEightChars = false;
  bool _hasCapitalLetters = false;
  bool _hasSpecialChar = false;
  bool loading = false;
  bool _isFormValid = false;

  @override
  void initState() {
    _isObscure = true;
    _isObscure1 = true;
    super.initState();
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
                "Create New \nPassword",
                style: FontStyles.headingText.copyWith(
                    color: PaintColors.paralexpurple,
                    fontWeight: FontWeight.w900),
              ),
              Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Email....
                      const SizedBox(height: 20),

                      Container(

                          // margin: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                        obscureText: _isObscure,
                        onChanged: (value) {
                          setState(() {
                            _hasEightChars = value.length >= 8;
                            _hasCapitalLetters =
                                RegExp(r'[A-Z]').hasMatch(value);
                            _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                .hasMatch(value);
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
                        // style: Font.smallText,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            // icon: Icon(Icons.person),
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
                                borderSide: BorderSide(
                                    color: PaintColors.paralexpurple))),
                      )),
                      Container(
                          // padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            obscureText: _isObscure1,
                            onChanged: (value) => (updateFormValidity()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a value";
                              } else if (value != _passwordController.text) {
                                return "Password do not match";
                              }
                              return null;
                            },
                            //fix
                            // style: Fonts.smallText,
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                                // icon: Icon(Icons.person),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isObscure1 = !_isObscure1;
                                      });
                                    },
                                    icon: _isObscure1
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                hintText: 'confirm password',
                                labelText: 'confirm password *',
                                border: const OutlineInputBorder()),
                          )),

                      const SizedBox(height: 20),
                      Column(
                        children: [
                          indicator(_hasEightChars, 'Minimum 8 Characters'),
                          const SizedBox(width: 10),
                          indicator(_hasCapitalLetters, 'one UPPERCASE Letter'),
                          const SizedBox(width: 10),
                          indicator(_hasSpecialChar,
                              'One Unique Character (e.g: !@#%^&*?)'),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Center(
                        child: ElevatedButton.icon(
                          onPressed: _isFormValid && !loading
                              ? _resetPassword
                              : null,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: _isFormValid
                                ? PaintColors.paralexpurple
                                : PaintColors.fadedPinkBg,
                            foregroundColor: Colors.white,
                            minimumSize: Size(size.width * 0.90, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
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
                              : Container(),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void updateFormValidity() {
    setState(() {
      _isFormValid = _hasEightChars &&
          _hasCapitalLetters &&
          _hasSpecialChar &&
          _passwordController.text == _confirmPasswordController.text &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
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

  Future<void> _resetPassword() async {
    if (!_key.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final response = await _apiService.postRequest(
        'api/v1/auth/reset-password',
        {
          'resetToken': userController.resetToken.value,
          'newPassword': _passwordController.text.trim(),
          'confirmPassword': _confirmPasswordController.text.trim(),
        },
      );
      Get.snackbar(
        'Success',
        response['message'] ?? 'Password reset successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.toNamed(Nav.finalStep);
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
        loading = false;
      });
    }
  }

}
