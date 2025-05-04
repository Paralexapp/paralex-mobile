import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/screens/users/auth_process/login.dart';
import '../../../../reusables/paints.dart';
import '../../../../service_provider/controllers/auth_controller.dart';
import '../../../../service_provider/controllers/user_choice_controller.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _isDarkMode = false;

  final UserChoiceController _userChoiceController = Get.find();

  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      Get.snackbar('Error', 'No image selected');
      return;
    }

    setState(() {
      _selectedImage = File(pickedFile.path);
    });

    final success = await _userChoiceController.updateProfilePhoto(_selectedImage!);

    if (success) {
      Get.snackbar('Success', 'Profile photo updated');
    } else {
      Get.snackbar('Error', 'Failed to update photo');
    }
  }



  @override
  void initState() {
    super.initState();
    _userChoiceController.fetchLoggedInUser().then((_) {
      print("Bio: ${_userChoiceController.aboutMe.value}");
      // Set the email and phone number fields after fetching the data
      _emailController.text = _userChoiceController.email.value;
      _phoneController.text = _userChoiceController.phoneNumber.value;
      _bioController.text = _userChoiceController.aboutMe.value;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: PaintColors.paralexpurple,
        appBarTheme: AppBarTheme(
          backgroundColor: PaintColors.paralexpurple,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Account Settings"),
        ),

        body: Padding(

          padding: const EdgeInsets.all(16.0),

          child: ListView(

            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage, // Function to pick image when tapped
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : (_userChoiceController.photoUrl.value.isNotEmpty
                        ? NetworkImage(_userChoiceController.photoUrl.value)
                        : AssetImage('assets/images/dummy-dp.png') as ImageProvider),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.edit,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              // Center(
              //   child: GestureDetector(
              //     onTap: _pickImage,
              //     child: CircleAvatar(
              //       radius: 50,
              //       backgroundImage: _selectedImage != null
              //           ? FileImage(_selectedImage!)
              //           : (_userChoiceController.photoUrl.value.isNotEmpty
              //           ? NetworkImage(_userChoiceController.photoUrl.value)
              //           : AssetImage('assets/images/law_catalogue.png') as ImageProvider),
              //       child: Align(
              //         alignment: Alignment.bottomRight,
              //         child: Icon(Icons.edit, size: 24, color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),

              _buildSectionTitle("Personal Information"),
              _buildTextField("Email", _emailController, isEditable: false),
              _buildTextField("Phone Number", _phoneController, isEditable: false),
              _buildSectionTitle("About Me"),
              _buildTextField("Short Bio", _bioController, isEditable: true),
              ElevatedButton(
                onPressed: () async {
                  final updatedBio = _bioController.text.trim();
                  final success = await _userChoiceController.updateBio(updatedBio);
                  if (success) {
                    Get.snackbar('Success', 'Bio updated successfully!',
                        snackPosition: SnackPosition.TOP);
                  } else {
                    Get.snackbar('Error', 'Failed to update bio.',
                        snackPosition: SnackPosition.TOP);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PaintColors.paralexpurple,
                ),
                child: const Text("Save Changes", style: TextStyle(color: Colors.white)),
              ),

              _buildSectionTitle("Change Password"),
              _buildTextField("Old Password", _oldPasswordController, obscureText: true),
              _buildTextField("New Password", _newPasswordController, obscureText: true),
              _buildTextField("Confirm Password", _confirmPasswordController, obscureText: true),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Logic to change password
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PaintColors.paralexpurple,
                ),
                child: const Text(
                  "Change Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              _buildSectionTitle("Preferences"),
              SwitchListTile(
                title: const Text("Enable Notifications"),
                value: true,
                onChanged: (bool newValue) {
                  // Handle preference change
                },
              ),
              SwitchListTile(
                title: const Text("Dark Mode"),
                value: _isDarkMode,
                onChanged: _toggleDarkMode,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call the logout function here
                  _userChoiceController.clearSession();  // Assuming this method handles the logout functionality
                  // Navigate to the login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginWithPassword()), // Replace LoginPage() with your actual login screen widget
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PaintColors.paralexpurple,
                ),
                child: const Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 40,),
              _buildDeleteAccount()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false, bool isEditable = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        enabled: isEditable,  // Allow editing or disable based on isEditable
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }

  Widget _buildDeleteAccount(){
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        onPressed: () => showAccountDeletionDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: PaintColors.grey, // Make it red for destructive action
          foregroundColor: Colors.red,
          fixedSize: const Size(200, 48),
        ),
        child: const Text('Delete Account', style: TextStyle(fontSize: 18),),
      ),
    );
  }


  void showAccountDeletionDialog(BuildContext context) {
    final authController = Get.find<UserChoiceController>();

    // First confirmation dialog
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account', style: TextStyle(color: Colors.red),),
        content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              authController.errorMessage.value ='';
              // Show email verification dialog
              _showEmailVerificationDialog(context, authController);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _showEmailVerificationDialog(BuildContext context, UserChoiceController controller) {
    final emailController = TextEditingController();

    Get.dialog(
      Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return AlertDialog(
          title: const Text('Confirm Account Deletion',style: TextStyle(color: Colors.red),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please enter your email address to confirm account deletion:'),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              if (controller.errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (emailController.text.trim() == _userChoiceController.email.value) {
                  final success = await controller.deleteAccount(emailController.text.trim());
                  if (success) {
                    Get.back(); // Close the dialog
                    // Navigate to login or show success message
                    Get.offAllNamed(Nav.login);
                    Get.snackbar('Success', 'Your account has been deleted');
                  }
                } else {
                  controller.errorMessage('Email does not match');
                }
              },
              child: const Text('Delete Account'),
            ),
          ],
        );
      }),
    );
  }
}
