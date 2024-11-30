import 'package:intl/intl.dart';

class AppMethod {
  static String formatDate(String inputDate) {
    // Define the input format
    final DateFormat inputFormat = DateFormat('dd-MMM-yyyy');

    // Define the output format
    final DateFormat outputFormat = DateFormat('yyyy-MM-dd');

    // Parse the input date
    final DateTime parsedDate = inputFormat.parse(inputDate.trim());

    // Format the date into the desired output format
    return outputFormat.format(parsedDate);
  }
}
