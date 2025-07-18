import 'dart:io';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/service_provider/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../service_provider/controllers/notification_controller.dart';
import '../../../service_provider/controllers/user_choice_controller.dart';
import '../../../service_provider/services/api_service.dart';

final userController = Get.find<UserChoiceController>();
final notificationController = Get.find<NotificationsController>();

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
  final ApiService _apiService = ApiService();

  bool _isObscure = true;
  bool _hasEightChars = false;
  bool _hasCapitalLetters = false;
  bool _hasSpecialChar = false;
  bool loading = false;
  bool _isFormValid = false;
  String? _emailSaved; // Loaded email
  String? _firstName;

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  Future<void> _loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email');
    final savedFirstName = prefs.getString('saved_first_name');
    if (savedEmail != null) {
      setState(() {
        _emailSaved = savedEmail;
        _firstName = savedFirstName;
        _emailController.text = savedEmail;
      });
    }
  }

  Future<void> _saveEmailAndName(String email, String firstName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_email', email);
    await prefs.setString('saved_first_name', firstName);
  }


  bool isEmailValid(String email) {
    return EmailValidator.validate(email);
  }

  void updateFormValidity() {
    setState(() {
      _isFormValid = _hasEightChars &&
          _hasCapitalLetters &&
          _hasSpecialChar &&
          _passwordController.text.isNotEmpty &&
          (_emailSaved != null || _emailController.text.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    userController.email.value = _emailController.text;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: PaintColors.bgColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _emailSaved != null
                    ? "Welcome back,\n${_firstName ?? _emailSaved}"
                    : "Welcome to \nParalex",
                style: FontStyles.headingText.copyWith(
                  color: PaintColors.paralexpurple,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              if (_emailSaved == null)
                Text(
                  "Committed to providing prompt,\nresponsive services ",
                  style: FontStyles.smallCapsIntro.copyWith(
                      color: PaintColors.generalTextsm, letterSpacing: 0),
                ),
              const SizedBox(height: 30),

              Form(
                key: _key,
                child: Column(
                  children: [
                    if (_emailSaved == null) ...[
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return "Enter a value";
                          if (!isEmailValid(value)) return "Enter a valid email";
                          return null;
                        },
                        onChanged: (value) => updateFormValidity(),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: 'you@email.com',
                          labelText: 'Email *',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PaintColors.paralexpurple),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    Container(
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
                                  borderSide: BorderSide(
                                      color: PaintColors.paralexpurple))),
                        )),

                    // TextFormField(
                    //   obscureText: _isObscure,
                    //   controller: _passwordController,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _hasEightChars = value.length >= 8;
                    //       _hasCapitalLetters = RegExp(r'[A-Z]').hasMatch(value);
                    //       _hasSpecialChar =
                    //           RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
                    //       updateFormValidity();
                    //     });
                    //   },
                    //   validator: (value) {
                    //     if (value!.isEmpty) return "Enter a value";
                    //     if (value.length < 8) return 'Min 8 characters';
                    //     if (!RegExp(r'[A-Z]').hasMatch(value)) return '1 capital letter';
                    //     if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value))
                    //       return '1 special character';
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     suffixIcon: IconButton(
                    //       icon: Icon(_isObscure
                    //           ? Icons.visibility
                    //           : Icons.visibility_off),
                    //       onPressed: () => setState(() => _isObscure = !_isObscure),
                    //     ),
                    //     hintText: 'password',
                    //     labelText: 'password *',
                    //     border: const OutlineInputBorder(),
                    //     focusedBorder: const OutlineInputBorder(
                    //       borderSide: BorderSide(color: PaintColors.paralexpurple),
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: 10),
                    if (_emailSaved == null)
                      Row(
                        children: [
                          indicator(_hasEightChars, '8+ Characters'),
                          const SizedBox(width: 10),
                          indicator(_hasCapitalLetters, '1 UPPERCASE'),
                          const SizedBox(width: 10),
                          indicator(_hasSpecialChar, '1 Special Char'),
                        ],
                      ),

                    if (_emailSaved != null) ...[
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _emailSaved = null;
                              _emailController.clear();
                            });
                          },
                          child: const Text(
                            "Use a different email",
                            style: TextStyle(color: PaintColors.paralexpurple),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => Get.toNamed(Nav.forgotPassword),
                      child: Text(
                        "Forgot password?",
                        style: FontStyles.smallCapsIntro.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: PaintColors.paralexpurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    ElevatedButton.icon(
                      onPressed: loading ? null : loginUser,
                      style: ElevatedButton.styleFrom(
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
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      )
                          : const SizedBox.shrink(),
                    ),

                    if (_emailSaved == null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Get.toNamed(Nav.lastWelcomeScreen),
                            child: Text(
                              "New here? Sign up.",
                              style: TextStyle(
                                fontSize: 16,
                                color: PaintColors.paralexpurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// class _LoginWithPasswordState extends State<LoginWithPassword> {
//   final AuthController _authController = Get.put(AuthController());
//   final GlobalKey<FormState> _key = GlobalKey();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final ApiService _apiService = ApiService(); // Instance of ApiService
//   bool _isObscure = true;
//   bool _hasEightChars = false;
//   bool _hasCapitalLetters = false;
//   bool _hasSpecialChar = false;
//   bool loading = false;
//   bool _isFormValid = false;
//
//   bool isEmailValid(String email) {
//     return EmailValidator.validate(email);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     userController.email.value = _emailController.text;
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: PaintColors.bgColor,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: PaintColors.bgColor,
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//               padding: const EdgeInsets.all(25),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header Section
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Welcome to \nParalex",
//                         style: FontStyles.headingText.copyWith(
//                             color: PaintColors.paralexpurple,
//                             fontWeight: FontWeight.w900),
//                       ),
//                       Text(
//                         "Committed to providing prompt,\nresponsive services ",
//                         style: FontStyles.smallCapsIntro.copyWith(
//                             color: PaintColors.generalTextsm, letterSpacing: 0),
//                       )
//                     ],
//                   ),
//
//                   // Form Section
//                   Form(
//                       key: _key,
//                       child: Column(
//                         children: [
//                           // Email Field
//                           const SizedBox(height: 20),
//                           Container(
//                             margin: const EdgeInsets.symmetric(vertical: 20),
//                             child: TextFormField(
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return "Enter a value";
//                                 }
//                                 if (!isEmailValid(value)) {
//                                   return "Please enter a valid email";
//                                 }
//                                 return null;
//                               },
//                               onChanged: (value) {
//                                 updateFormValidity();
//                               },
//                               keyboardType: TextInputType.emailAddress,
//                               controller: _emailController,
//                               decoration: const InputDecoration(
//                                   prefixIcon: Icon(Icons.email_outlined),
//                                   hintText: 'you@email.com',
//                                   labelText: 'Email *',
//                                   border: OutlineInputBorder(),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: PaintColors.paralexpurple))),
//                             ),
//                           ),
//                           // Password Field
//                           Container(
//                               child: TextFormField(
//                             obscureText: _isObscure,
//                             onChanged: (value) {
//                               setState(() {
//                                 _hasEightChars = value.length >= 8;
//                                 _hasCapitalLetters =
//                                     RegExp(r'[A-Z]').hasMatch(value);
//                                 _hasSpecialChar =
//                                     RegExp(r'[!@#$%^&*(),.?":{}|<>]')
//                                         .hasMatch(value);
//                                 updateFormValidity();
//                               });
//                             },
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Enter a value";
//                               } else if (value.length < 8) {
//                                 return 'Password must be at least 8 characters';
//                               } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
//                                 return 'Password must have at least one capital letter';
//                               } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
//                                   .hasMatch(value)) {
//                                 return 'Password must have at least one special character';
//                               }
//                               return null;
//                             },
//                             controller: _passwordController,
//                             decoration: InputDecoration(
//                                 suffixIcon: IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         _isObscure = !_isObscure;
//                                       });
//                                     },
//                                     icon: _isObscure
//                                         ? const Icon(Icons.visibility)
//                                         : const Icon(Icons.visibility_off)),
//                                 hintText: 'password',
//                                 labelText: 'password *',
//                                 border: const OutlineInputBorder(),
//                                 focusedBorder: const OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: PaintColors.paralexpurple))),
//                           )),
//
//                           // New here? Sign up link
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,  // Align to the end (right)
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   // Navigate to the signup page
//                                   Get.toNamed(Nav.lastWelcomeScreen);  // Replace `Nav.lastWelcomeScreen` with the actual route to the signup page
//                                 },
//                                 child: Text(
//                                   "New here? Sign up.",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: PaintColors.paralexpurple,  // Or use a color that fits your design
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                           // Password Validation Indicators
//                           const SizedBox(height: 20),
//                           Column(
//                             children: [
//                               indicator(_hasEightChars, 'Minimum 8 Characters'),
//                               const SizedBox(width: 10),
//                               indicator(
//                                   _hasCapitalLetters, 'One UPPERCASE Letter'),
//                               const SizedBox(width: 10),
//                               indicator(_hasSpecialChar,
//                                   'One Unique Character (e.g: !@#%^&*?)'),
//                             ],
//                           ),
//                           const SizedBox(height: 50),
//                           InkWell(
//                             onTap: () => Get.toNamed(Nav.forgotPassword),
//                             child: Text(
//                               "Forgot password?",
//                               style: FontStyles.smallCapsIntro.copyWith(
//                                   letterSpacing: 0,
//                                   fontWeight: FontWeight.w900,
//                                   fontSize: 14,color: PaintColors.paralexpurple),
//                             ),
//                           ),
//
//                           const SizedBox(height: 30),
//                           // Submit Button
//                           Center(
//                               child: ElevatedButton.icon(
//                                   onPressed: loading ? null : loginUser,
//                                   style: ElevatedButton.styleFrom(
//                                       elevation: 0,
//                                       backgroundColor: _isFormValid
//                                           ? PaintColors.paralexpurple
//                                           : PaintColors.fadedPinkBg,
//                                       foregroundColor: Colors.white,
//                                       minimumSize: Size(size.width * 0.90, 48),
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8))),
//                                   label: Text(
//                                     loading ? "LOADING..." : "CONTINUE",
//                                     style: FontStyles.headingText
//                                         .copyWith(fontSize: 20),
//                                   ),
//                                   icon: loading
//                                       ? Container(
//                                           width: 30,
//                                           height: 30,
//                                           padding: const EdgeInsets.all(2.0),
//                                           child:
//                                               const CircularProgressIndicator(
//                                             color: Colors.white,
//                                             strokeWidth: 3,
//                                           ),
//                                         )
//                                       : Container()))
//                         ],
//                       )),
//                 ],
//               )),
//         ));
//   }
//
//   void updateFormValidity() {
//     setState(() {
//       _isFormValid = _hasEightChars &&
//           _hasCapitalLetters &&
//           _hasSpecialChar &&
//           _passwordController.text.isNotEmpty &&
//           _emailController.text.isNotEmpty;
//     });
//   }

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
      // Step 1: Authenticate the user and retrieve the token
      final response = await _apiService.postRequest(
        'api/v1/auth/login',
        loginData,
      );

      if (response['data'] == null) {
        throw Exception("Invalid response from server.");
      }


      final authToken = response['data'];
      _authController.token.value = authToken;
      _authController.userEmail.value = _emailController.text;
      userController.authToken.value = authToken;

      // ✅ Step 2: Fetch user data by email (BEFORE using firstName)
      final userData = await userController.fetchUserByEmail(_emailController.text);

      if (userData.isEmpty) {
        throw Exception("User not found.");
      }

      final String firstName = userData['firstName'] ?? 'there';
      final String lastName = userData['lastName'] ?? '';
      final String registrationLevel = userData['registrationLevel'] ?? '';
      final String userType = userData['userType'] ?? '';
      final String userId = userData['id'] ?? '';

      // ✅ Save both email and name
      await _saveEmailAndName(_emailController.text, firstName);

      // Set firstName in state
      setState(() {
        _firstName = firstName;
      });

      // Save user details to controller
      userController.firstName.value = firstName;
      userController.lastName.value = lastName;
      userController.userIdToken.value = userId;
      // Set initial UserType
      if (userType == 'SERVICE_PROVIDER_LAWYER') {
        userController.setInitialUserType(UserType.SERVICE_PROVIDER_LAWYER);
      } else if (userType == 'SERVICE_PROVIDER_RIDER') {
        userController.setInitialUserType(UserType.SERVICE_PROVIDER_RIDER);
      } else if (userType == 'USER') {
        userController.setInitialUserType(UserType.USER);
      } else {
        Get.snackbar('Error', 'Unknown user type.', snackPosition: SnackPosition.TOP);
        return;
      }

      // Step 3: Navigate based on registrationLevel and userType
      if (registrationLevel != 'KYC_COMPLETED') {
        if (userType == 'SERVICE_PROVIDER_LAWYER') {
          Get.toNamed(Nav.aboutYouForLawyer);
        } else if (userType == 'SERVICE_PROVIDER_RIDER') {
          Get.toNamed(Nav.aboutServiceProvider);
        } else if (userType == 'USER') {
          Get.toNamed(Nav.tellusMoreforUsers);
        } else {
          Get.snackbar('Error', 'Unknown user type.', snackPosition: SnackPosition.TOP);
          return;
        }
      } else {
        if (userType == 'SERVICE_PROVIDER_LAWYER') {
          userController.selectServiceProviderLawyer();
          notificationController.fetchNotifications(includeUserId: true);
          notificationController.fetchNotifications(includeUserId: false);
          Get.toNamed(Nav.lawyerDashboard, arguments: {
            'firstName': firstName,
            'lastName': lastName,
          });
        } else if (userType == 'SERVICE_PROVIDER_RIDER') {
          userController.selectServiceProviderRider();
          notificationController.fetchNotifications(includeUserId: true);
          notificationController.fetchNotifications(includeUserId: false);
          Get.toNamed(Nav.deliveryInfo1, arguments: {
            'firstName': firstName,
            'lastName': lastName,
          });
        } else if (userType == 'USER') {
          userController.selectUser();
          notificationController.fetchNotifications(includeUserId: true);
          notificationController.fetchNotifications(includeUserId: false);
          Get.toNamed(Nav.home, arguments: {
            'firstName': firstName,
            'lastName': lastName,
          });
        } else {
          Get.snackbar('Error', 'Unknown user type.', snackPosition: SnackPosition.TOP);
        }
      }
    } catch (e, _) {  // Catch error but discard stack trace
      String errorMessage = "An unexpected error occurred.";

      // Handle network errors first
      if (e is SocketException || e.toString().contains("Failed host lookup")) {
        errorMessage = "Network is not connected.";
      } else if (e is DioException) {
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          errorMessage = "Network is not connected.";
        } else if (e.type == DioExceptionType.badResponse) {
          if (e.response?.statusCode == 401) {
            errorMessage = "Invalid email or password.";
          } else {
            errorMessage = "Something went wrong.";
          }
        }
      }

      // Only show the cleaned-up message, never the full error
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.TOP);
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
