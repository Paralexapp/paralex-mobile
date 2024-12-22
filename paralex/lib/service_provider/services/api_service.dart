import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../controllers/auth_controller.dart';

class ApiService {
  // final String baseUrl = 'https://paralex-app-fddb148a81ad.herokuapp.com/api/v1/auth';
  final String baseUrl = 'https://paralex-app-fddb148a81ad.herokuapp.com';
  final AuthController _authController = Get.put(AuthController());

  Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    debugPrint('url==$url');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authController.token.value}'
        },
        body: jsonEncode(data),
      );
      debugPrint('response>>>>${response.body}');
      debugPrint('response>>>>${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        // Parse the response body to extract debugMessage
        final responseBody = jsonDecode(response.body);
        String errorMessage =
            responseBody['debugMessage'] ?? responseBody['message'] ?? response.body;
        debugPrint('response>>>>${response}');
        // Display the actual error message
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
        );

        // Throw the actual error message as an exception
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Handle unexpected errors and display the actual error details
      String errorMessage = e.toString();
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.TOP,
      );

      // Rethrow the exception with the actual error message
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> putRequest(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    debugPrint('url==$url');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        // Handle error response
        final responseBody = jsonDecode(response.body);
        String errorMessage = responseBody['debugMessage'] ?? 'An error occurred.';
        throw Exception(errorMessage);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to connect to the server.',
        snackPosition: SnackPosition.BOTTOM,
      );
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    debugPrint('url==$url');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_authController.token.value}',
        },
      );
      debugPrint('response${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        if (responseBody is List) {
          return {'data': response.body};
        } else {
          return responseBody;
        }
        // return {"data": response.body};
      } else {
        // Parse the response body to extract debugMessage
        final responseBody = jsonDecode(response.body);
        String errorMessage =
            responseBody['debugMessage'] ?? responseBody['message'] ?? response.body;

        // Display the actual error message
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
        );

        // Throw the actual error message as an exception
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint('error====$e');
      // Handle unexpected errors and display the actual error details
      String errorMessage = e.toString();
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.TOP,
      );

      // Rethrow the exception with the actual error message
      throw Exception(errorMessage);
    }
  }

  Future<String> uploadImage(File file) async {
    String uploadedImageUrl = '';
    var url = Uri.parse('$baseUrl/api/v1/auth/upload-media');
    try {
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseBody = await jsonDecode(response.stream.toString());
        uploadedImageUrl = responseBody['secure_url'];
        return uploadedImageUrl;
      } else {
        Get.snackbar(
          'Error',
          "Failed to upload image. Status code: ${response.statusCode}",
          snackPosition: SnackPosition.TOP,
        );
        throw Exception("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        "An error occurred while uploading the image: $e",
        snackPosition: SnackPosition.TOP,
      );
      throw Exception("An error occurred while uploading the image: $e");
    }
  }

  Future<String> uploadImage1(File file) async {
    String uploadedImageUrl = '';
    var url = Uri.parse('$baseUrl/api/v1/auth/upload-to-cloudinary');
    try {
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();

      // Read the response stream into a string
      String responseString = await response.stream.bytesToString();
      responseString = responseString.trim(); // Remove any leading/trailing whitespace
      debugPrint('Raw Response String: $responseString');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Server returned plain text (URL)
        if (Uri.tryParse(responseString)?.isAbsolute == true) {
          uploadedImageUrl = responseString; // Assign the URL directly
          return uploadedImageUrl;
        } else {
          throw Exception("Unexpected response format: $responseString");
        }
      } else {
        // Handle error responses
        throw Exception(
          "Failed to upload image. Status code: ${response.statusCode}. Response: $responseString",
        );
      }
    } catch (e) {
      debugPrint("Error during image upload: $e");
      throw Exception("An error occurred while uploading the image: $e");
    }
  }
}


