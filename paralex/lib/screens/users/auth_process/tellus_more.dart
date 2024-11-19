import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/service_provider/controllers/user_choice_controller.dart';
import 'package:paralax/service_provider/repo/local/local_storage.dart';
import 'package:paralax/service_provider/services/firebase_service.dart';
import 'package:paralax/service_provider/services/hive_service.dart';
import 'package:paralax/service_provider/services/http_service.dart';

class MoreAboutYou extends StatefulWidget {
  const MoreAboutYou({super.key});

  @override
  State<MoreAboutYou> createState() => _MoreAboutYouState();
}

class _MoreAboutYouState extends State<MoreAboutYou> {
  final FirebaseService auth = FirebaseService();
  final HttpService api = HttpService();
  final UserChoiceController controller = Get.put(UserChoiceController());
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  String phoneNumber = '';
  String state = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tell us more about you",
              style: FontStyles.headingText
                  .copyWith(color: PaintColors.paralaxpurple, fontSize: 22),
            ),
            Text("Please use your name as it \nappears on your ID",
                style: FontStyles.smallCapsIntro.copyWith(
                    letterSpacing: 0,
                    color: PaintColors.generalTextsm,
                    fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a value";
                    }
                    return null;
                  },

                  // style: Fonts.smallText,
                  keyboardType: TextInputType.text,
                  controller: _firstName,
                  decoration: const InputDecoration(
                      // prefixIcon: Icon(Icons.email_outlined),
                      // icon: Icon(Icons.person),
                      hintText: 'Legal first name',
                      labelText: 'First name *',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: PaintColors.paralaxpurple))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a value";
                    }
                    return null;
                  },

                  // style: Fonts.smallText,
                  keyboardType: TextInputType.text,
                  controller: _lastName,
                  decoration: const InputDecoration(
                      // prefixIcon: Icon(Icons.email_outlined),
                      // icon: Icon(Icons.person),
                      hintText: 'Legal last name',
                      labelText: 'Last name *',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: PaintColors.paralaxpurple))),
                ),
                const SizedBox(
                  height: 20,
                ),
                IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    log(phone.completeNumber);
                    setState(() {
                      phoneNumber = phone.completeNumber;
                    });
                    // print(phone.completeNumber);
                  },
                  onCountryChanged: (country){
                    log(country.name);
                    setState(() {
                      state = country.name;
                    });
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  readOnly: true, // Make it readonly
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    final DateTime? picked =
                        await DatePicker.showSimpleDatePicker(
                      context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      dateFormat: "dd-MMMM-yyyy",
                      locale: DateTimePickerLocale.en_us,
                      looping: true,
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked;
                        _dateController.text =
                            DateFormat("dd-MMM-yyyy").format(picked);
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async{
                    log('continue button tapped');
                    try{
                      setState(() {
                        loading = true;
                      });
                      // await auth.saveUserData(username: '${_firstName.text} ${_lastName.text}', email: controller.userEmail.value, phoneNumber: phoneNumber);
                      // log('firestore check');
                      Map<String, dynamic> requestBodyCreateUser = {
                        "idToken": controller.userIdToken.value,
                        "stateOfResidence": state,
                        "phoneNumber": phoneNumber
                      };
                      var res = await api.postData(HttpService.createAccount, controller.userIdToken.value, requestBodyCreateUser);
                      log('api check');
                      if(res != null){
                        log('$res');
                        setState(() {
                          loading = false;
                        });
                        Get.snackbar('Success', 'Account successfully created');
                        Get.toNamed(Nav.login);
                      }
                      else{
                        setState(() {
                          loading = false;
                        });
                        log('api response is null');
                        Get.snackbar('Error', 'Account creation failed');
                        Get.toNamed(Nav.login);
                      }
                    }
                    catch(e){
                      setState(() {
                        loading = false;
                      });
                      log('$e');
                      Get.snackbar('Error', "$e");
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: size.width * 0.85,
                    decoration: const BoxDecoration(
                        color: PaintColors.paralaxpurple,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                        child: loading == true ? Container(
                          width: 30,
                          height: 30,
                          padding: const EdgeInsets.all(1.0),
                          child:
                          const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ) : Text(
                      "CONTINUE",
                      style: FontStyles.smallCapsIntro.copyWith(
                          color: Colors.white,
                          letterSpacing: 0,
                          fontSize: 15,
                          fontWeight: FontWeight.w800),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
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
                            "Terms of",
                            style: FontStyles.smallCapsIntro.copyWith(
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                color: PaintColors.paralaxpurple,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Service",
                              style: FontStyles.smallCapsIntro.copyWith(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: PaintColors.paralaxpurple,
                                  fontSize: 14)),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("and"),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Privacy policy ",
                            style: FontStyles.smallCapsIntro.copyWith(
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                color: PaintColors.paralaxpurple,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
