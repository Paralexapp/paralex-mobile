import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';

import '../../../../routes/navs.dart';

class StepOne extends StatefulWidget {
  const StepOne({super.key});

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  bool isEmailValid(String email) {
    return EmailValidator.validate(email);
  }

  bool _isFormValid = false;
  bool loading = false;

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
                    color: PaintColors.paralaxpurple,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Enter your phone number and we'll send you\nan OTP code to get back into your account ",
                style: FontStyles.smallCapsIntro.copyWith(
                    color: PaintColors.generalTextsm, letterSpacing: 0),
              ),
              Form(
                  key: _key,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        // padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter a value";
                            }
                            if (!isEmailValid(value)) {
                              return "Please enter a vaild email";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            updateFormValidity();
                          },

                          // style: Fonts.smallText,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              // icon: Icon(Icons.person),
                              hintText: 'you@email.com',
                              labelText: 'Email *',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: PaintColors.paralaxpurple))),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: ElevatedButton.icon(
                              onPressed: () {
                                if (!_key.currentState!.validate()) {
                                  return;
                                }
                                Get.toNamed(Nav.resetPassOtp);
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: _isFormValid
                                      ? PaintColors.paralaxpurple
                                      : PaintColors.fadedPinkBg,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(size.width * 0.90, 48),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              label: Text(
                                "CONTINUE",
                                style: FontStyles.headingText
                                    .copyWith(fontSize: 20),
                              ),
                              icon: loading == true
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
                  ))
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
}
