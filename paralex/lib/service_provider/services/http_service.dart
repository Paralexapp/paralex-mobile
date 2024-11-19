import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:paralex/service_provider/services/exception_handler.dart';

class HttpService {

  static const String endpoint = 'https://staging.api.paralexapp.com';
  static String createAccount = '$endpoint/user';
  static String verifyUser = '$endpoint/user/verify';
  static String sendEmailVerification = '$endpoint/user/send/email-verification';

  Future<dynamic> fetchData(String url, String bearerToken) async {
    try{
      http.Response response = await http.get(Uri.parse(url),
        headers: {
          "Authorization": "Bearer $bearerToken",
          "Content-Type": "application/json",
        },
      );
      log('${response.statusCode}');
      ExceptionHandler.checkApiStatusCode(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 204 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 203) {
        log(response.body);
        String fetchedData = response.body;
        return fetchedData;
      }
      else {
        log('${response.statusCode}');
        log('failed to get/fetch result from the endpoint');
        return null;
      }
    }
    catch(e){
      log('$e');
    }
  }


  Future<dynamic> postData(String url, String bearerToken, Map<String, dynamic> requestBody) async {
    try{
      http.Response response = await http.post(Uri.parse(url),
        headers: {
          "Authorization": "Bearer $bearerToken",
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );
      log('${response.statusCode}');
      ExceptionHandler.checkApiStatusCode(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 204 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 203) {
        log(response.body);
        String postedData = response.body;
        return postedData;
      }
      else {
        log('${response.statusCode}');
        log('Error, not successful--API');
        log(response.body);
        return null;
      }
    }
    catch (e){
      log('$e');
    }
  }

}

///flutter build apk --split-per-abi