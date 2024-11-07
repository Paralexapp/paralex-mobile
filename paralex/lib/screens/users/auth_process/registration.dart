import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UserRegistration> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  var _isObscure;
  bool _hasEightChars = false;
  bool _hasCapitalLetters = false;
  bool _hasSpecialChar = false;
  bool loading = false;
  bool _isFormValid = false;

  bool isEmailValid(String email) {
    return EmailValidator.validate(email);
  }

  @override
  void initState() {
    _isObscure = true;

    // plugin.initialize(publicKey: pstack_key);
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
                  //01s
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to \nParalex",
                        style: FontStyles.headingText.copyWith(
                            color: PaintColors.paralaxpurple,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "Committed to providing prompt,\nresponsive services ",
                        style: FontStyles.smallCapsIntro.copyWith(
                            color: PaintColors.generalTextsm, letterSpacing: 0),
                      )
                    ],
                  ),

                  Form(
                      key: _key,
                      child: Column(
                        children: [
                          //Email....
                          const SizedBox(height: 20),
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
                          Container(
                              // margin: const EdgeInsets.symmetric(vertical: 20),
                              child: TextFormField(
                            obscureText: _isObscure,
                            onChanged: (value) {
                              setState(() {
                                _hasEightChars = value.length >= 8;
                                _hasCapitalLetters =
                                    RegExp(r'[A-Z]').hasMatch(value);
                                _hasSpecialChar =
                                    RegExp(r'[!@#$%^&*(),.?":{}|<>]')
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
                                        color: PaintColors.paralaxpurple))),
                          )),
                          Container(
                              // padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: TextFormField(
                                obscureText: _isObscure,
                                onChanged: (value) => (updateFormValidity()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter a value";
                                  } else if (value !=
                                      _passwordController.text) {
                                    return "Password do not match";
                                  }
                                },
                                //fix
                                // style: Fonts.smallText,
                                controller: _confirmPasswordController,
                                decoration: InputDecoration(
                                    // icon: Icon(Icons.person),
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: _isObscure
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
                              indicator(
                                  _hasCapitalLetters, 'one UPPERCASE Letter'),
                              const SizedBox(width: 10),
                              indicator(_hasSpecialChar,
                                  'One Unique Character (e.g: !@#%^&*?)'),
                            ],
                          ),
                          const SizedBox(height: 20),

                          Center(
                              child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (!_key.currentState!.validate()) {
                                      return;
                                    }
                                    Get.toNamed(Nav.otpScreen);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: _isFormValid
                                          ? PaintColors.paralaxpurple
                                          : PaintColors.fadedPinkBg,
                                      foregroundColor: Colors.white,
                                      minimumSize: Size(size.width * 0.90, 48),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
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
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : Container()))
                        ],
                      ))
                  //end of 01
                ],
              )),
        ));
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
}
