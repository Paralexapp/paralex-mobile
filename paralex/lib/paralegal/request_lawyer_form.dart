import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paralex/reusables/back_button.dart';
import '../reusables/fonts.dart';
import '../reusables/paints.dart';
import '../routes/navs.dart';
import '../service_provider/view/widgets/custom_button.dart';
import '../service_provider/view/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

import '../service_provider/view/widgets/date_picker.dart';
import 'lawyer_controller.dart';
import 'lawyer_model.dart';

// class DateTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     // Remove any non-digit characters
//     String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
//
//     // Automatically format the date as "dd-MM-yyyy"
//     StringBuffer formattedText = StringBuffer();
//
//     // Extract day, month, and year parts from input
//     String dayPart = '';
//     String monthPart = '';
//     String yearPart = '';
//
//     if (text.length >= 1) {
//       dayPart = text.substring(0, Math.min(2, text.length));
//
//       // Ensure the day is valid (01-31 at this stage)
//       int day = int.parse(dayPart);
//       if (day > 31) dayPart = '31';
//       formattedText.write(dayPart);
//     }
//
//     if (text.length >= 3) {
//       formattedText.write('-');
//       monthPart = text.substring(2, Math.min(4, text.length));
//
//       // Ensure the month is valid (01-12)
//       int month = int.parse(monthPart);
//       if (month > 12) monthPart = '12';
//       formattedText.write(monthPart);
//     }
//
//     if (text.length >= 5) {
//       formattedText.write('-');
//       yearPart = text.substring(4, Math.min(8, text.length));
//
//       // Optional: Ensure year is within a reasonable range (1900-2100)
//       if (yearPart.length == 4) {
//         int year = int.parse(yearPart);
//         if (year < 1900) yearPart = '1900';
//         if (year > 2100) yearPart = '2100';
//       }
//
//       formattedText.write(yearPart);
//     }
//
//     // Validate day based on month and year
//     if (dayPart.isNotEmpty && monthPart.isNotEmpty && yearPart.length == 4) {
//       int day = int.parse(dayPart);
//       int month = int.parse(monthPart);
//       int year = int.parse(yearPart);
//
//       // Adjust the day based on month and year (accounting for leap years)
//       int maxDays = _getMaxDaysInMonth(month, year);
//       if (day > maxDays) {
//         day = maxDays;
//         dayPart = day.toString().padLeft(2, '0');
//       }
//
//       // Update the formatted text with validated day
//       formattedText = StringBuffer('${dayPart}-${monthPart}-${yearPart}');
//     }
//
//     // Limit to maximum length of "dd-MM-yyyy"
//     if (formattedText.length > 10) {
//       formattedText = StringBuffer(formattedText.toString().substring(0, 10));
//     }
//
//     return TextEditingValue(
//       text: formattedText.toString(),
//       selection: TextSelection.collapsed(offset: formattedText.length),
//     );
//   }
//
//   // Helper method to get the maximum number of days in a month, accounting for leap years
//   int _getMaxDaysInMonth(int month, int year) {
//     switch (month) {
//       case 1: // January
//       case 3: // March
//       case 5: // May
//       case 7: // July
//       case 8: // August
//       case 10: // October
//       case 12: // December
//         return 31;
//       case 4: // April
//       case 6: // June
//       case 9: // September
//       case 11: // November
//         return 30;
//       case 2: // February
//         return _isLeapYear(year) ? 29 : 28;
//       default:
//         return 31;
//     }
//   }
//
//   // Helper method to determine if a year is a leap year
//   bool _isLeapYear(int year) {
//     if (year % 4 != 0) return false;
//     if (year % 100 == 0 && year % 400 != 0) return false;
//     return true;
//   }
// }

class RequestLawyerForm extends StatefulWidget {
  final String? imgPath;
  final String? lawyerName;
  final String? specialization;
  final double? rating;
  final int? reviewCount;
  final double? hourlyRates;
  final Lawyer? lawyer;

  const RequestLawyerForm({
    super.key,
    this.imgPath,
    this.lawyerName,
    this.specialization,
    this.rating,
    this.reviewCount,
    this.hourlyRates,
    this.lawyer,
  });

  @override
  State<RequestLawyerForm> createState() => _RequestLawyerFormState();
}

class _RequestLawyerFormState extends State<RequestLawyerForm> {
  final LawyerController _controller = Get.put(LawyerController());

  FlutterSoundRecorder? _recorder;
  AudioPlayer? _audioPlayer;
  bool isRecording = false;
  bool hasRecording = false;
  String? filePath;
  String recordingUrl = '';
  Duration recordingDuration = Duration.zero;
  Duration currentPlaybackPosition = Duration.zero;
  bool isPlaying = false;
  bool isPaused = false;
  String? _selectedPracticeArea;
  String? _selectedNgStates;
  bool _isButtonEnabled = false;

  File? _imageFile;
  String? _uploadedImageUrl;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _practiceAreaController = TextEditingController();
  final TextEditingController _ngStatesController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _matterTitleController = TextEditingController();
  final TextEditingController _matterDescController = TextEditingController();

  bool _areAllFieldsValid() {
    return _nameController.text.isNotEmpty &&
        _matterTitleController.text.isNotEmpty &&
        _matterDescController.text.isNotEmpty &&
        _ngStatesController.text.isNotEmpty &&
        _deadlineController.text.length == 10;
  }

  final List<String> _practiceAreas = [
    "Tax",
    "Criminal Law",
    "Family Law",
    "Corporate Law",
    "Intellectual Property",
    "Real Estate",
    "Employment Law",
    "Personal Injury",
    "Immigration Law",
  ];

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

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _audioPlayer = AudioPlayer();
    _initializeRecorder();
    _audioPlayer?.onDurationChanged.listen((Duration d) {
      setState(() {
        recordingDuration = d;
      });
    });

    _audioPlayer?.onPositionChanged.listen((Duration p) {
      setState(() {
        currentPlaybackPosition = p;
      });
    });

    _audioPlayer?.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        isPaused = false;
        currentPlaybackPosition = Duration.zero;
      });
    });

    _countryController.text = "Nigeria";

    void updateButtonState() {
      setState(() {
        _isButtonEnabled = _areAllFieldsValid();
      });
    }

    _nameController.addListener(updateButtonState);
    _matterDescController.addListener(updateButtonState);
    _matterTitleController.addListener(updateButtonState);
    _ngStatesController.addListener(updateButtonState);
    _deadlineController.addListener(updateButtonState);
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    _audioPlayer?.dispose();
    _countryController.dispose();
    _deadlineController.dispose();
    _practiceAreaController.dispose();
    _ngStatesController.dispose();
    _matterTitleController.dispose();
    _matterDescController.dispose();
    super.dispose();
  }

  Future<void> _initializeRecorder() async {
    if (await _requestMicrophonePermission()) {
      await _recorder?.openRecorder();
      await _recorder?.setSubscriptionDuration(Duration(milliseconds: 500));
    } else {
      // Handle the case where permission was denied
      Get.snackbar("ERROR", 'Microphone permission is required to record audio.',
          snackPosition: SnackPosition.TOP);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content:
      //           Text('Microphone permission is required to record audio.')),
      // );
    }
  }

  Map<String, dynamic> submitForm() {
    var form = {
      "matterTitle": _matterTitleController.text,
      "matterDescription": _matterDescController.text,
      "matterRecordingUrl": filePath,
      "deadline": _deadlineController.text,
      "files": [
        {"name": "optional file", "url": _uploadedImageUrl},
        {"name": "recording ", "url": recordingUrl}
      ],
      "lawyerProfileId": widget.lawyer?.id,
      "lawFirmId": widget.lawyer?.id,
      "userId": widget.lawyer?.user?.id,
      "amount": 0
    };

    return form;
  }

  Future<bool> _requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied || status.isRestricted || status.isLimited) {
      status = await Permission.microphone.request();
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }

    return false;
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickMedia();

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      _uploadedImageUrl = await _controller.uploadFile(_imageFile!);
    }
  }

  Future<void> _startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    filePath = p.join(tempDir.path, '${DateTime.now().millisecondsSinceEpoch}.aac');

    await _recorder?.startRecorder(
      toFile: filePath,
      codec: Codec.aacADTS,
    );

    setState(() {
      isRecording = true;
      recordingDuration = Duration.zero;
    });

    _recorder?.onProgress?.listen((e) {
      setState(() {
        recordingDuration = e.duration;
      });
    });
  }

  Future<void> _stopRecording() async {
    await _recorder?.stopRecorder();
    setState(() {
      isRecording = false;
      hasRecording = true;
    });
  }

  void _playPauseRecording() async {
    if (filePath == null) {
      print("No file path found; exiting _playPauseRecording");
      return;
    }

    if (isPlaying && !isPaused) {
      await _audioPlayer?.pause();
      setState(() {
        isPaused = true;
        isPlaying = false;
        currentPlaybackPosition = currentPlaybackPosition; // Capture the pause position
      });
    } else if (isPaused) {
      await _audioPlayer?.play(DeviceFileSource(filePath!),
          position: currentPlaybackPosition);
      setState(() {
        isPaused = false;
        isPlaying = true;
      });
    } else {
      await _audioPlayer?.play(DeviceFileSource(filePath!));
      setState(() {
        isPlaying = true;
        isPaused = false;
        currentPlaybackPosition = Duration.zero;
      });
    }
  }

  void _stopPlayback() async {
    await _audioPlayer?.stop();
    setState(() {
      isPlaying = false;
      isPaused = false;
      currentPlaybackPosition = Duration.zero;
    });
  }

  void _uploadRecording() async {
    if (filePath != null) {
      recordingUrl = await _controller.uploadFile(File(filePath!));
    }
  }

  void _deleteRecording() {
    if (isPlaying || isPaused) {
      _stopPlayback();
    }

    if (filePath != null) {
      File(filePath!).deleteSync();
      filePath = null;
      recordingUrl = '';
    }
    setState(() {
      hasRecording = false;
      isPlaying = false;
      isPaused = false;
      currentPlaybackPosition = Duration.zero;
    });
  }

  String _formatDuration(Duration duration) {
    return DateFormat('mm:ss').format(DateTime(0).add(duration));
  }

  Future<void> _showPracticeAreaDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Practice Area'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _practiceAreas.map((area) {
                    return RadioListTile<String>(
                      title: Text(area),
                      value: area,
                      groupValue: _selectedPracticeArea,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPracticeArea = value;
                        });
                        // Close the dialog and set the selected value in the TextField
                        Navigator.pop(context);
                        _practiceAreaController.text = value!;
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
          title: Text(
            'Get a Lawyer',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.lawyerName!,
                          style: FontStyles.headingText.copyWith(
                              color: Color(0xFF35124E),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Lawyer based in Lagos",
                          style: FontStyles.smallCapsIntro.copyWith(
                              color: Color(0xFF4A4A68), fontSize: 12, letterSpacing: 0),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.specialization!,
                            style: FontStyles.smallCapsIntro.copyWith(
                                color: Color(0xFF4A4A68), fontSize: 15, letterSpacing: 0),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xFFFFC403),
                                size: 12,
                              ),
                              Text(
                                widget.rating.toString(),
                                style: FontStyles.smallCapsIntro.copyWith(
                                    color: Color(0xFF4A4A68),
                                    fontSize: 11,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "(${widget.reviewCount} Reviews)",
                                style: FontStyles.smallCapsIntro.copyWith(
                                    color: Color(0xFF4A4A68),
                                    fontSize: 11,
                                    letterSpacing: 0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
                InkWell(
                  onTap: () =>
                      Get.offNamedUntil(Nav.findAlawyer, ModalRoute.withName(Nav.home)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: PaintColors.fadedPinkBg,
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Color(0xFF35124E),
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.menu,
                              color: PaintColors.fadedPinkBg,
                            )),
                        SizedBox(width: 8),
                        Text(
                          'Change Lawyer',
                          style: FontStyles.smallCapsIntro.copyWith(
                              fontSize: 13,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF35124E)),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next,
                          color: PaintColors.paralexpurple,
                        )
                      ],
                    ),
                  ),
                ),
                StyledTextWidget(
                  firstText: "Client's full name",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0, color: const Color(0xFF868686), fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: _nameController,
                  hintText: "Ade Balogun",
                  onChanged: (value) {},
                ),
                Text(
                  "Change if hiring a lawyer or law firm for a third party",
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF1A2C56),
                      fontSize: 14,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Practice Area",
                  secondText: "(optional)",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0, color: const Color(0xFF868686), fontSize: 15),
                  secondTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  hintText: "E.g Tax",
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                  ontap: _showPracticeAreaDialog,
                  readonly: true,
                  controller: _practiceAreaController,
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Matter Title",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0, color: const Color(0xFF868686), fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: _matterTitleController,
                  hintText: "E.g Debt Recovery",
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Matter Description",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0, color: const Color(0xFF868686), fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: _matterDescController,
                  hintText: "Tell us a bit about your matter",
                  maxline: 6,
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Record Description",
                  secondText: "(Optional)",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0, color: const Color(0xFF868686), fontSize: 15),
                  secondTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0x70ECF1F4),
                      border: Border.all(color: Color(0xFFE4E4E4))),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onLongPressStart: (details) {
                            // Start recording when the button is pressed
                            _startRecording();
                          },
                          onLongPressEnd: (details) {
                            // Stop recording when the button is released
                            _stopRecording();
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: isRecording ? Colors.red : PaintColors.paralexpurple,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Iconsax.microphone,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (isRecording) ...[
                          Text(
                            "Recording... ${_formatDuration(recordingDuration)}",
                            style: TextStyle(color: Color(0xFF8B9EB4), fontSize: 14),
                          ),
                        ] else if (hasRecording) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _playPauseRecording();
                                },
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Color(0xFF1A2C56),
                                ),
                              ),
                              IconButton(
                                onPressed: _deleteRecording,
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Recorded: ${_formatDuration(recordingDuration)}",
                            style: TextStyle(color: Color(0xFF8B9EB4), fontSize: 14),
                          ),
                          if (isPlaying)
                            Text(
                              "Playing... ${_formatDuration(currentPlaybackPosition)}",
                              style: TextStyle(color: Color(0xFF8B9EB4), fontSize: 14),
                            ),
                        ],
                        if (!isRecording && !hasRecording)
                          Text(
                            "Hold to Record",
                            style: TextStyle(color: Color(0xFF8B9EB4), fontSize: 14),
                          ),
                        if (hasRecording && !isRecording)
                          Column(
                            children: [
                              Text("Recording Ready"),
                              SizedBox(
                                height: 10.0,
                              ),
                              (recordingUrl.isEmpty)
                                  ? ElevatedButton(
                                      onPressed: _uploadRecording,
                                      child: Text("Upload Recording"),
                                    )
                                  : Text(
                                      recordingUrl,
                                      style: TextStyle(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                            ],
                          ),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  "Drop a recording of your matter description",
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF1A2C56),
                      fontSize: 14,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Lawyer's/law Firm's location",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0, color: const Color(0xFF868686), fontSize: 15),
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
                        hintText: "Enugu",
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
                  firstText: "Deadline",
                  secondText: "*",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0, color: const Color(0xFF868686), fontSize: 15),
                  secondTextStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                // CustomTextField(
                //   controller: _deadlineController,
                //   keyboardType: TextInputType.number,
                //   hintText: "09-11-2020",
                //   inputFormatter: [DateTextInputFormatter()],
                // ),
                ReusableDatePicker(
                  controller: _deadlineController,
                  labelText: "",
                  onDateChanged: (date) {
                    // print('Selected date: $date');
                  },
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2099),
                ),
                SizedBox(height: 15),
                StyledTextWidget(
                  firstText: "Add a File",
                  secondText: "(optional)",
                  firstTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0, color: const Color(0xFF868686), fontSize: 15),
                  secondTextStyle: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      color: const Color(0xFF868686),
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 8),

                GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: _uploadedImageUrl == null
                      ? Container(
                          height: 113,
                          color: Color(0x70ECF1F4),
                          child: DottedBorder(
                            color: Colors.grey,
                            strokeWidth: 1,
                            dashPattern: [6, 4],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(8),
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
                                  Text('Upload File',
                                      style: FontStyles.smallCapsIntro.copyWith(
                                          letterSpacing: 0,
                                          color: PaintColors.paralexpurple,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    'Supports Jpg,Pdf,Docs & Video',
                                    style: FontStyles.smallCapsIntro.copyWith(
                                        letterSpacing: 0,
                                        color: Color(0xFF999999),
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : _imageFile != null
                          ? (_uploadedImageUrl!.endsWith(".jpg") ||
                                  _uploadedImageUrl!.endsWith(".png") ||
                                  _uploadedImageUrl!.endsWith(".jpeg"))
                              ? Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.file_present,
                                      color: Colors.blue,
                                      size: 50,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'File Uploaded!$_uploadedImageUrl',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                          : null,
                ),
                SizedBox(height: 35),
                CustomButton(
                  desiredWidth: 0.9,
                  buttonText: "Get a Lawyer",
                  buttonColor: _isButtonEnabled
                      ? PaintColors.paralexpurple
                      : PaintColors.fadedPinkBg,
                  ontap: () {
                    _isButtonEnabled
                        ? _controller.requestLitigationSupport(submitForm())
                        : Get.snackbar(
                            "",
                            "Fill all required fields",
                            snackPosition: SnackPosition.TOP,
                            titleText: Text(
                              "Error",
                              style: TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.bold),
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
