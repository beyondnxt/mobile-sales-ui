import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lingam/const/api_url.dart';
import 'package:lingam/services/store_login_value.dart';

import '../services/location_services.dart';

class AttendanceProvider with ChangeNotifier {
  LocationServices locationServices = LocationServices();
  bool isLoading = false;
  bool userAlreadyPresent = false;
  String punchInTime = "";
  String puchOutTime = "";
  String dateTime = "";
  Future<dynamic> checkInApi() async {
    try {
      isLoading = true;
      notifyListeners();
      num latitude = 0.0;
      num longitude = 0.0;
      await locationServices.determinePosition().then((value) {
        print(value);
        latitude = value.latitude;
        longitude = value.longitude;
      });

      var body = json.encode({"latitude": latitude, "longitude": longitude});
      var userId = await StoreLoginValue.getUserID();
      var response = await http.put(
          Uri.parse("${APIEndPoints.mainUrl}attendance/updatePunchIn/$userId"),
          body: body);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Punch In Success");
      } else {
        Fluttertoast.showToast(msg: jsonData["message"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> checkOutApi() async {
    try {
      isLoading = true;
      notifyListeners();
      num latitude = 0.0;
      num longitude = 0.0;
      await locationServices.determinePosition().then((value) {
        print(value);
        latitude = value.latitude;
        longitude = value.longitude;
      });

      var body = json.encode({"latitude": latitude, "longitude": longitude});
      var userId = await StoreLoginValue.getUserID();
      var response = await http.put(
          Uri.parse("${APIEndPoints.mainUrl}attendance/updatePunchOut/$userId"),
          body: body);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Punch In Success");
      } else {
        Fluttertoast.showToast(msg: jsonData["message"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> getLastAttendanceApi() async {
    try {
      String? userId = await StoreLoginValue.getUserID();
      var headers = {
        'userId': userId ?? "",
      };

      var response = await http.get(
          Uri.parse("${APIEndPoints.mainUrl}attendance/last"),
          headers: headers);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200 && jsonData.isNotEmpty) {
        punchInTime = jsonData["punchIn"] == null
            ? ""
            : convertLocalTime(jsonData["punchIn"]);
        puchOutTime = jsonData["punchOut"] == null
            ? ""
            : convertLocalTime(jsonData["punchOut"]);
        print(punchInTime + jsonData["punchIn"]);
        print(puchOutTime + jsonData["punchOut"]);
        if (jsonData["createdOn"] != null) {
          DateTime data = DateTime.parse(jsonData["createdOn"]);
          dateTime = DateFormat('MM-dd-yyyy').format(data);
        }
        if (jsonData["punchOut"] == null) {
          userAlreadyPresent = true;
          notifyListeners();
        }
        print(response.body);
      } else {}
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }
  String convertLocalTime (String time){


  // Parse the time string into a DateTime object
  DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);

  // Create a new DateTime object with the desired time
  DateTime desiredTime = DateTime(parsedTime.year, parsedTime.month, parsedTime.day, parsedTime.hour, parsedTime.minute, 0);

  // Format the DateTime object into the desired time format
  String formattedTime = DateFormat('hh:mm a').format(desiredTime);
return formattedTime;

  }
}
