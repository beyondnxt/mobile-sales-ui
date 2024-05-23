import 'package:intl/intl.dart';

class DateTimeConverter {
 static String convertLocalToServerTime(String localTime) {
    // Convert local time to UTC
    DateTime utcTime = DateTime.parse(localTime).toUtc();

    // Format UTC time to send to the server
    String formattedUtcTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(utcTime);

    return formattedUtcTime;
  }

 static String convertServerTimeToLocal(String dateTime) {
    try {
    DateTime utcTime = DateTime.parse(dateTime);
    DateTime localTime = utcTime.toLocal();
    String formattedLocalTime = DateFormat('yyyy-MM-dd hh:mm a').format(localTime);
    print('Local Time: $formattedLocalTime');
    return formattedLocalTime;
  } catch (e) {
    print('Error parsing date: $e');
    return ''; // Return empty string if parsing fails
  }
  }
}
