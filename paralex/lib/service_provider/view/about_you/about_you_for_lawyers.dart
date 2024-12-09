import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../reusables/back_button.dart';
import '../../../reusables/fonts.dart';
import '../../../reusables/paints.dart';
import '../../../routes/navs.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class AboutYouForLawyers extends StatelessWidget {
  AboutYouForLawyers({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController practiceAreaController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final List<String> statesInNigeria = [
    'Abia',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara',
    'FCT (Abuja)'
  ];

  final List<String> practiceAreas = [
    "Alternative Dispute Resolution Practices.",
    "Aviation",
    "Banking And Finance",
    "Business Establishment and Corporate Immigration",
    "Capital markets",
    "Company secretarial services",
    "Compliance and Investigation",
    "Corporate Advisory",
    "Corporate Governance",
    "Employment",
    "Energy and natural resources",
    "Entertainments",
    "Human Rights",
    "International Law",
    "Criminal Law",
    "Land Law",
    "International trade",
    "Intellectual property",
    "Litigation",
    "civil and criminal",
    "Mergers, acquisitions and restructuring",
    "Telecommunications, media and Technology",
    "Information Technology",
    "Oil and Gas",
    "Power",
    "Probono",
    "Public policy and regulations",
    "Real Estate and Property Management",
    "Shipping, maritime Legal Advisory",
    "Tax",
    "Startup Funding"
  ];

  // Boolean to track phone number validity
  bool isPhoneNumberValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: PinkButton.backButton,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey, // Attach the GlobalKey to the Form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tell us more about you",
                  style: FontStyles.headingText.copyWith(
                    color: PaintColors.paralexpurple,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "Please use your name as it \nappears on your ID",
                  style: FontStyles.smallCapsIntro.copyWith(
                    letterSpacing: 0,
                    color: PaintColors.generalTextsm,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Legal last name',
                  labelText: 'Legal last name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your legal name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Residential address',
                  labelText: 'Residential address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your residential address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                IntlPhoneField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xFFECF1F4),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  ),
                  initialCountryCode: 'NG',
                  onChanged: (value) {
                    // Check validity of phone number on every change
                    if (value.completeNumber.isNotEmpty &&
                        RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value.completeNumber)) {
                      isPhoneNumberValid = true;
                    } else {
                      isPhoneNumberValid = false;
                    }
                  },
                  onSaved: (value) {
                    // Save phone number and validate
                    if (value != null &&
                        value.completeNumber.isNotEmpty &&
                        RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value.completeNumber)) {
                      isPhoneNumberValid = true;
                    } else {
                      isPhoneNumberValid = false;
                    }
                  },
                ),
                CustomTextFormField(
                  hintText: 'Law firm (Optional)',
                  labelText: 'Law firm (Optional)',
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Supreme Court number',
                  labelText: 'Supreme Court number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Supreme Court number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    String? practiceArea = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select a Practice Area'),
                          backgroundColor: Colors.white,
                          content: SizedBox(
                            width: double.maxFinite,
                            height: 300,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: practiceAreas.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(practiceAreas[index]),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pop(practiceAreas[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );

                    if (practiceArea != null) {
                      practiceAreaController.text = practiceArea;
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: practiceAreaController,
                      hintText: 'Aviation',
                      labelText: 'Practice Area',
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a Practice Area";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    String? selectedState = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select a State'),
                          backgroundColor: Colors.white,
                          content: SizedBox(
                            width: double.maxFinite,
                            height: 300,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: statesInNigeria.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(statesInNigeria[index]),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pop(statesInNigeria[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                    if (selectedState != null) {
                      stateController.text = selectedState;
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: stateController,
                      hintText: 'Lagos',
                      labelText: 'State',
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a state";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                desiredWidth: 0.85,
                buttonText: "CONTINUE",
                buttonColor: PaintColors.paralexpurple,
                ontap: () {
                  if (!_formKey.currentState!.validate()) {
                    // If other required fields are invalid
                    Get.snackbar('Error', 'Please fill in all required fields.');
                  } else if (!isPhoneNumberValid) {
                    // If phone number is invalid
                    Get.snackbar('Error', 'Please enter a valid phone number.');
                  } else {
                    // If all fields, including the phone number, are valid
                    Get.snackbar('Success', 'All fields are valid!');
                    // Navigate to the home page
                    Get.toNamed(Nav.bondSubmitted);
                  }

                },
              ),
              const SizedBox(height: 20),
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
                          "Terms of ",
                          style: FontStyles.smallCapsIntro.copyWith(
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold,
                              color: PaintColors.paralexpurple,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Service"),
                        SizedBox(
                          width: 5,
                        ),
                        Text("and"),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Privacy policy "),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



