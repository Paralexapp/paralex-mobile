import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';

class MoreAboutYou extends StatefulWidget {
  const MoreAboutYou({super.key});

  @override
  State<MoreAboutYou> createState() => _MoreAboutYouState();
}

class _MoreAboutYouState extends State<MoreAboutYou> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
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
              ],
            ))
          ],
        ),
      ),
    );
  }
}
