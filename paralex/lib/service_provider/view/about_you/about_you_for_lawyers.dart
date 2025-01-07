import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paralex/service_provider/controllers/user_choice_controller.dart';
import '../../../reusables/back_button.dart';
import '../../../reusables/fonts.dart';
import '../../../reusables/paints.dart';
import '../../../routes/navs.dart';
import '../../services/api_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'package:geolocator/geolocator.dart';

final userChoiceController = Get.find<UserChoiceController>();



Future<Position> _getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  // Check for location permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception(
        'Location permissions are permanently denied. Cannot request permissions.');
  }

  // Get the current location
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low,
  );
}


class AboutYouForLawyers extends StatefulWidget {
  const AboutYouForLawyers({super.key});

  @override
  State<AboutYouForLawyers> createState() => _AboutYouForLawyersState();
}

class _AboutYouForLawyersState extends State<AboutYouForLawyers> {
  File? passportImage ;
  String? photoUrl;
  String? firstName ;
  String? lastName;
  String? address;
  String lawFirm = '';
  String? courtNumber;
  String? phoneNumber;
  List<String> selectedPracticeAreas = [];
  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _stateOfResidenceController = TextEditingController();
  final TextEditingController _stateOfPracticeController = TextEditingController();
  final TextEditingController _practiceAreaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
    "Tax",
    "Criminal Law",
    "Family Law",
    "Corporate Law",
    "Intellectual Property",
    "Real Estate",
    "Employment Law",
    "Personal Injury",
    "Immigration Law"
    // "Alternative Dispute Resolution Practices.",
    // "Aviation",
    // "Banking And Finance",
    // "Business Establishment and Corporate Immigration",
    // "Capital markets",
    // "Company secretarial services",
    // "Compliance and Investigation",
    // "Corporate Advisory",
    // "Corporate Governance",
    // "Employment",
    // "Energy and natural resources",
    // "Entertainments",
    // "Human Rights",
    // "International Law",
    // "Criminal Law",
    // "Land Law",
    // "International trade",
    // "Intellectual property",
    // "Litigation",
    // "Civil and Criminal",
    // "Mergers, acquisitions and restructuring",
    // "Telecommunications, media and Technology",
    // "Information Technology",
    // "Oil and Gas",
    // "Power",
    // "Probono",
    // "Public policy and regulations",
    // "Real Estate and Property Management",
    // "Shipping, maritime Legal Advisory",
    // "Tax",
    // "Startup Funding"
  ];

  // Boolean to track phone number validity
  bool isPhoneNumberValid = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      final fileExtension = pickedFile.path.split('.').last.toLowerCase();
      if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
        setState(() {
          passportImage = File(pickedFile.path);
        });
      } else {
        Get.snackbar("Invalid File", "Please select a JPG or JPEG image.");
      }
    }
  }

  void removeImage() {
    setState(() {
      passportImage = null;
    });
  }

  @override
  void dispose() {
    _practiceAreaController.dispose();
    _phoneController.dispose();
    _stateOfPracticeController.dispose();
    _stateOfResidenceController.dispose();
    super.dispose();
  }

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
                  hintText: 'Legal first name',
                  labelText: 'Legal first name',
                  validator: (value) {
                    firstName = value;
                    if (value == null || value.isEmpty) {
                      return "Please enter your legal first name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Legal last name',
                  labelText: 'Legal last name',
                  validator: (value) {
                    lastName = value;
                    if (value == null || value.isEmpty) {
                      return "Please enter your legal last name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Residential address',
                  labelText: 'Residential address',
                  validator: (value) {
                    address = value;
                    if (value == null || value.isEmpty) {
                      return "Please enter your residential address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                IntlPhoneField(
                  controller: _phoneController,
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
                    phoneNumber = value.completeNumber;
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
                  onChanged: (value){
                    lawFirm = value;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Supreme Court number',
                  labelText: 'Supreme Court number',
                  validator: (value) {
                    courtNumber = value;
                    if (value == null || value.isEmpty) {
                      return "Please enter your Supreme Court number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    // A set to store selected practice areas
                    Set<String> selectedPracticeAreas = Set.from(
                        _practiceAreaController.text.split(',').map((e) => e.trim()));

                    Set<String>? result = await showDialog<Set<String>>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Practice Areas'),
                          backgroundColor: Colors.white,
                          content: StatefulBuilder(
                            builder: (context, setState) {
                              return SizedBox(
                                width: double.maxFinite,
                                height: 300,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: practiceAreas.length,
                                  itemBuilder: (context, index) {
                                    final practiceArea = practiceAreas[index];
                                    return CheckboxListTile(
                                      title: Text(practiceArea),
                                      value: selectedPracticeAreas.contains(practiceArea),
                                      onChanged: (bool? isChecked) {
                                        setState(() {
                                          if (isChecked ?? false) {
                                            selectedPracticeAreas.add(practiceArea);
                                          } else {
                                            selectedPracticeAreas.remove(practiceArea);
                                          }
                                        });
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(null); // Cancel selection
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(selectedPracticeAreas);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );

                    // Update the controller with selected items
                    if (result != null && result.isNotEmpty) {
                      _practiceAreaController.text = result.join(', ');
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: _practiceAreaController,
                      hintText: 'Select Practice Areas',
                      labelText: 'Practice Areas',
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select at least one Practice Area";
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
                      _stateOfResidenceController.text = selectedState;
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: _stateOfResidenceController,
                      hintText: 'Lagos',
                      labelText: 'State of Residence',
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
                      _stateOfPracticeController.text = selectedState;
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: _stateOfPracticeController,
                      hintText: 'Lagos',
                      labelText: 'State of Practice',
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
                const SizedBox(height: 20),
                StyledTextWidget(
                  firstText: "Add your Image",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                if (passportImage == null) ...[
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 113,
                      color: const Color(0x70ECF1F4),
                      child: DottedBorder(
                        color: Colors.grey,
                        strokeWidth: 1,
                        dashPattern: [6, 4],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.insert_drive_file,
                                color: Colors.grey[400],
                                size: 50,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Upload File',
                                style: TextStyle(
                                  color: Color(0xFF511F4A),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Supports JPG or JPEG',
                                style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 113,
                        width: 113,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(passportImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: removeImage,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 35),
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
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomButton(
                    desiredWidth: 0.85,
                    buttonText: isLoading ? "" : "CONTINUE",
                    buttonColor: PaintColors.paralexpurple,
                    ontap: () async {
                      if (isLoading) return; // Prevent multiple presses

                      if (!_formKey.currentState!.validate()) {
                        Get.snackbar('Error', 'Please fill in all required fields.');
                      } else if (!isPhoneNumberValid) {
                        Get.snackbar('Error', 'Please enter a valid phone number.');
                      } else if (passportImage == null) {
                        Get.snackbar('Error', 'Please select a valid image.');
                      } else {
                        setState(() {
                          isLoading = true;
                        });

                        List<String> practiceAreaList = _practiceAreaController.text
                            .split(',') // Split by comma
                            .map((e) => e.trim()) // Trim whitespace
                            .where((e) => e.isNotEmpty) // Remove empty strings
                            .toList();

                        try {
                          Position position = await _getCurrentLocation();
                          double latitude = position.latitude;
                          double longitude = position.longitude;

                          Get.snackbar('Uploading', 'Uploading image... Please wait.');
                          ApiService apiService = ApiService();

                          String uploadedPhotoUrl = await apiService.uploadImage1(passportImage!);
                          photoUrl = uploadedPhotoUrl;

                          Map<String, dynamic> formData = {
                            "email": userChoiceController.email.value,
                            "firstName": firstName,
                            "lastName": lastName,
                            "phoneNumber": phoneNumber,
                            "supremeCourtNumber": courtNumber,
                            "stateOfResidence": _stateOfResidenceController.text,
                            "stateOfPractice": _stateOfPracticeController.text,
                            "practiceAreas": practiceAreaList,
                            "photoUrl": photoUrl,
                            "longitude": longitude,
                            "latitude": latitude,
                            "lawFirm": lawFirm
                          };

                          Get.snackbar('Submitting', 'Submitting your information...');
                          debugPrint("Form Data: ${jsonEncode(formData)}");
                          var response = await apiService.postRequest(
                            'service-provider/lawyer/profile/',
                            formData,
                          );

                          Get.snackbar('Success', 'Profile updated successfully!');
                          Get.offNamed(Nav.home);
                          // Get.offNamed(Nav.lawyerDashboard, arguments: {
                          //   'firstName': firstName,
                          //   'lastName': lastName,
                          // });
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        } finally {
                          setState(() {
                            isLoading = false; // Stop loading
                          });
                        }
                      }
                    },
                  ),

                  if (isLoading)
                    Positioned(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                ],
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

class StyledTextWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final TextStyle firstTextStyle;
  final TextStyle secondTextStyle;

  const StyledTextWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.firstTextStyle,
    required this.secondTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: firstTextStyle,
          ),
          TextSpan(
            text: secondText,
            style: secondTextStyle,
          ),
        ],
      ),
    );
  }
}

