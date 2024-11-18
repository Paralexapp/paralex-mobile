import 'dart:developer';
import 'package:http/http.dart' as http;

class HttpService {

  static const String endpoint = 'https://staging.api.paralexapp.com';
  static String createAccount = '$endpoint/user';
  static String sendEmailVerification = '$endpoint/user/send/email-verification';
  Map<String, dynamic> requestBodyCreateUser = {
    "idToken": "string",
    "stateOfResidence": "string",
    "phoneNumber": "string"
  };
  Map<String, dynamic> requestBodyEmailVerification ={
    "idToken": "string"
  };


  Future<dynamic> fetchData(String url) async {
    http.Response response = await http.get(Uri.parse(url),
      headers: {
        // 'X-CMC_PRO_API_KEY': '7f6e4145-4b4d-4221-86c2-6f3c76c4b63d',
        "Accept": "application/json",
      },);
    log('${response.statusCode}');

    if (response.statusCode == 200) {
      log(response.body);
      String fetchedData = response.body;
      return fetchedData;
    }
    else {
      log('${response.statusCode}');
    }
  }

  Future<dynamic> postData(String url, Map<String, dynamic> requestBody) async {
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        // 'X-CMC_PRO_API_KEY': '7f6e4145-4b4d-4221-86c2-6f3c76c4b63d',
        "Accept": "application/json",
      },
    body: requestBody,
    );
    log('${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      log(response.body);
      String postedData = response.body;
      return postedData;
    }
    else {
      log('${response.statusCode}');
    }
  }

}