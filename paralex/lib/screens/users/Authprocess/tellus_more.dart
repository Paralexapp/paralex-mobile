import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:paralax/routes/navs.dart';

class MoreAboutYou extends StatefulWidget {
  const MoreAboutYou({super.key});

  @override
  State<MoreAboutYou> createState() => _MoreAboutYouState();
}

class _MoreAboutYouState extends State<MoreAboutYou> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
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
                    // print(phone.completeNumber);
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
                  onTap: () => Get.toNamed(Nav.login),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: size.width * 0.85,
                    decoration: const BoxDecoration(
                        color: PaintColors.paralaxpurple,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                        child: Text(
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
