import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paralex/reusables/back_button.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/custom_text_field.dart';
import 'dart:math' as Math;
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Remove any non-digit characters
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Automatically format the date as "dd-MM-yyyy"
    StringBuffer formattedText = StringBuffer();

    // Extract day, month, and year parts from input
    String dayPart = '';
    String monthPart = '';
    String yearPart = '';

    if (text.isNotEmpty) {
      dayPart = text.substring(0, Math.min(2, text.length));

      // Ensure the day is valid (01-31 at this stage)
      int day = int.parse(dayPart);
      if (day > 31) dayPart = '31';
      formattedText.write(dayPart);
    }

    if (text.length >= 3) {
      formattedText.write('-');
      monthPart = text.substring(2, Math.min(4, text.length));

      // Ensure the month is valid (01-12)
      int month = int.parse(monthPart);
      if (month > 12) monthPart = '12';
      formattedText.write(monthPart);
    }

    if (text.length >= 5) {
      formattedText.write('-');
      yearPart = text.substring(4, Math.min(8, text.length));

      // Optional: Ensure year is within a reasonable range (1900-2100)
      if (yearPart.length == 4) {
        int year = int.parse(yearPart);
        if (year < 1900) yearPart = '1900';
        if (year > 2100) yearPart = '2100';
      }

      formattedText.write(yearPart);
    }

    // Validate day based on month and year
    if (dayPart.isNotEmpty && monthPart.isNotEmpty && yearPart.length == 4) {
      int day = int.parse(dayPart);
      int month = int.parse(monthPart);
      int year = int.parse(yearPart);

      // Adjust the day based on month and year (accounting for leap years)
      int maxDays = _getMaxDaysInMonth(month, year);
      if (day > maxDays) {
        day = maxDays;
        dayPart = day.toString().padLeft(2, '0');
      }

      // Update the formatted text with validated day
      formattedText = StringBuffer('$dayPart-$monthPart-$yearPart');
    }

    // Limit to maximum length of "dd-MM-yyyy"
    if (formattedText.length > 10) {
      formattedText = StringBuffer(formattedText.toString().substring(0, 10));
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  // Helper method to get the maximum number of days in a month, accounting for leap years
  int _getMaxDaysInMonth(int month, int year) {
    switch (month) {
      case 1: // January
      case 3: // March
      case 5: // May
      case 7: // July
      case 8: // August
      case 10: // October
      case 12: // December
        return 31;
      case 4: // April
      case 6: // June
      case 9: // September
      case 11: // November
        return 30;
      case 2: // February
        return _isLeapYear(year) ? 29 : 28;
      default:
        return 31;
    }
  }

  // Helper method to determine if a year is a leap year
  bool _isLeapYear(int year) {
    if (year % 4 != 0) return false;
    if (year % 100 == 0 && year % 400 != 0) return false;
    return true;
  }
}

class UpdateServiceForLawyer extends StatefulWidget {

  const UpdateServiceForLawyer({super.key,});

  @override
  State<UpdateServiceForLawyer> createState() => _UpdateServiceForLawyerState();
}

class _UpdateServiceForLawyerState extends State<UpdateServiceForLawyer> {
  String? _selectedPracticeArea;
  String? _selectedNgStates;
  bool _isButtonEnabled = false;
  File? passportImage ;

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _dateOfUpdateController = TextEditingController();
  final TextEditingController _practiceAreaController = TextEditingController();
  final TextEditingController _ngStatesController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _updateAreaController = TextEditingController();
  final TextEditingController _matterDescController = TextEditingController();

  bool _areAllFieldsValid() {
    return _nameController.text.isNotEmpty &&
        _updateAreaController.text.isNotEmpty &&
        _matterDescController.text.isNotEmpty && _practiceAreaController.text.isNotEmpty &&
        _ngStatesController.text.isNotEmpty &&
        _dateOfUpdateController.text.length == 10 && passportImage != null;
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _areAllFieldsValid();
    });
  }

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
        _updateButtonState();
      } else {
        Get.snackbar("Invalid File", "Please select a JPG or JPEG image.");
      }
    }
  }

  void removeImage() {
    setState(() {
      passportImage = null;
    });
    _updateButtonState();
  }

  final List<String> _nigeriaStates = [
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
    'Federal Capital Territory'
  ];
  void showWellDonePopup(BuildContext context) {
    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
          ),
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Makes dialog compact
            children: [
              SvgPicture.asset("assets/images/designed_check.svg"),
              SizedBox(height: 16.0),
              Text(
                "Well Done!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Update is being reviewed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 24.0),
              CustomButton(
                  desiredWidth: 0.85,
                  buttonText: "Done",
                  buttonColor: PaintColors.paralexpurple,
                  ontap:(){
                    //Get.toNamed(Nav.deliveryInfo1);
                  })
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _countryController.text = "Nigeria";
    _nameController.addListener(_updateButtonState);
    _matterDescController.addListener(_updateButtonState);
    _updateAreaController.addListener(_updateButtonState);
    _ngStatesController.addListener(_updateButtonState);
    _dateOfUpdateController.addListener(_updateButtonState);
    _practiceAreaController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _countryController.dispose();
    _dateOfUpdateController.dispose();
    _practiceAreaController.dispose();
    _ngStatesController.dispose();
    _updateAreaController.dispose();
    _matterDescController.dispose();
    super.dispose();
  }

  Future<void> _showNgStatesDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a State'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _nigeriaStates.map((area) {
                    return RadioListTile<String>(
                      title: Text(area),
                      value: area,
                      groupValue: _selectedNgStates,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedNgStates = value;
                        });
                        // Close the dialog and set the selected value in the TextField
                        Navigator.pop(context);
                        _ngStatesController.text = value!;
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: Get.back, icon: PinkButton.backButton),
          centerTitle: true,
          title: Text(
            'Update Service',
            style: FontStyles.smallCapsIntro.copyWith(
                fontSize: 18,
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF511F4A)),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledTextWidget(
                  firstText: "Lawyer name",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: _nameController,
                  hintText: "Ade Balogun",
                  onChanged: (value) {},
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Practice Area",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: _practiceAreaController,
                  hintText: "Land Law",
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Update Area",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: _updateAreaController,
                  hintText: "Land Dispute",
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Matter Description",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: _matterDescController,
                  hintText: "Matter Description",
                  maxline: 10,
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Lawyer's/law Firm's location",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _countryController,
                        hintText: "Country",
                        readonly: true,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: CustomTextField(
                        hintText: "Ondo",
                        suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                        controller: _ngStatesController,
                        ontap: _showNgStatesDialog,
                        readonly: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Date of Update",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: _dateOfUpdateController,
                  keyboardType: TextInputType.number,
                  hintText: "09-11-2020",
                  inputFormatter: [DateTextInputFormatter()],
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Add Image",
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
                CustomButton(
                  desiredWidth: 0.9,
                  buttonText: "UPDATE  DATABASE",
                  buttonColor: _isButtonEnabled
                      ? PaintColors.paralexpurple
                      : PaintColors.fadedPinkBg,
                  ontap: () {
                    _isButtonEnabled
                        ?  showWellDonePopup(context)
                        : Get.snackbar(
                      "",
                      "Fill all required fields",
                      snackPosition: SnackPosition.TOP,
                      titleText: Text(
                        "Error",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    );
                  },

                ),
              ],
            ),
          ),
        ));
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
