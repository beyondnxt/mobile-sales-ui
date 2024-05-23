import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lingam/const/api_url.dart';
import 'package:lingam/controller/login_provider.dart';
import 'package:lingam/services/store_login_value.dart';
import 'package:lingam/view/loginScreen/login_screen.dart';
import 'package:provider/provider.dart';

import '../services/location_services.dart';

class AttendanceProvider with ChangeNotifier {
  bool? isCheckIn;
  LocationServices locationServices = LocationServices();
  bool isLoading = false;
  bool userAlreadyPresent = false;
  String punchInTime = "";
  String puchOutTime = "";
  String dateTime = "";
  Future<dynamic> checkInApi(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      num latitude = 0.0;
      num longitude = 0.0;
      await locationServices.determinePosition(context).then((value) {
        print(value);
        latitude = value.latitude;
        longitude = value.longitude;
      });
      if (latitude == 0.0 || longitude == 0.0) {
        locationServices.showLocationPermissionDialog(context);
        return;
      }
      var userId = await StoreLoginValue.getUserID();
      var token = await StoreLoginValue.getTokenId();
      var headers = {
        "userId": userId.toString(),
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };
      var body = json.encode({"latitude": latitude, "longitude": longitude});

      var response = await http.put(
          Uri.parse("${APIEndPoints.mainUrl}attendance/updatePunchIn/$userId"),
          body: body,
          headers: headers);
      var jsonData = json.decode(response.body);
      print(headers);
      print(body);
      print("${APIEndPoints.mainUrl}attendance/updatePunchIn/$userId");
      print(jsonData);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Punch In Success");
        await getLastAttendanceApi(context);
        await getAttendanceStatus(context);
      } else if (response.statusCode == 401) {
        // var userName = await StoreLoginValue.getUserName();
        // var password = await StoreLoginValue.getUserPassword();
        // provider.loginAuth(context, userName!, password!).then((value) {
        //   checkInApi(context);
        // });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const LoginScreen()),
            (route) => false);
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

  Future<dynamic> checkOutApi(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      num latitude = 0.0;
      num longitude = 0.0;
      await locationServices.determinePosition(context).then((value) {
        print(value);
        latitude = value.latitude;
        longitude = value.longitude;
      });
      var userId = await StoreLoginValue.getUserID();
      var token = await StoreLoginValue.getTokenId();
      var headers = {
        "userId": userId.toString(),
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };

      var body = json.encode({"latitude": latitude, "longitude": longitude});

      var response = await http.put(
          Uri.parse("${APIEndPoints.mainUrl}attendance/updatePunchOut/$userId"),
          body: body,
          headers: headers);
      var jsonData = json.decode(response.body);
      print(headers);
      print(body);
      print("${APIEndPoints.mainUrl}attendance/updatePunchOut/$userId");
      print(jsonData);
      if (response.statusCode == 200) {
        await getLastAttendanceApi(context);
        await getAttendanceStatus(context);

        Fluttertoast.showToast(msg: "Punch Out Success");
      } else if (response.statusCode == 401) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const LoginScreen()),
            (route) => false);
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

  Future<dynamic> getLastAttendanceApi(BuildContext context) async {
    try {
      isLoading = true;
      var userId = await StoreLoginValue.getUserID();
      var token = await StoreLoginValue.getTokenId();
      var headers = {
        "userId": userId.toString(),
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };
      punchInTime = "";
      puchOutTime = "";
      dateTime = "";
      var response = await http.get(
          Uri.parse("${APIEndPoints.mainUrl}attendance/last"),
          headers: headers);
      var jsonData = json.decode(response.body);
      print(jsonData);
      print(response.statusCode);
      if (response.statusCode == 200 && jsonData.isNotEmpty) {
        DateTime data = DateTime.parse(jsonData["createdOn"]);
        dateTime = DateFormat('MM-dd-yyyy').format(data);
        punchInTime = jsonData["punchIn"] == null
            ? ""
            : convertLocalTime(jsonData["punchIn"]);
        puchOutTime = jsonData["punchOut"] == null
            ? ""
            : convertLocalTime(jsonData["punchOut"]);
        print(punchInTime + jsonData["punchIn"]);
        print(puchOutTime + jsonData["punchOut"]);
        if (jsonData["createdOn"] != null) {
          print('uuuuuuuuu');

          print(dateTime);
          print(jsonData["createdOn"]);
        }
        if (jsonData["punchOut"] == null) {
          userAlreadyPresent = true;
          notifyListeners();
        }
        print(response.body);
      } else if (response.statusCode == 401) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const LoginScreen()),
            (route) => false);
      } else {
        Fluttertoast.showToast(msg: jsonData["message"]);
      }
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String convertLocalTime(String time) {
    // Parse the time string into a DateTime object
    DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);

    // Create a new DateTime object with the desired time
    DateTime desiredTime = DateTime(parsedTime.year, parsedTime.month,
        parsedTime.day, parsedTime.hour, parsedTime.minute, 0);

    // Format the DateTime object into the desired time format
    String formattedTime = DateFormat('hh:mm a').format(desiredTime);
    return formattedTime;
  }

  Future<dynamic> getAttendanceStatus(BuildContext context) async {
    try {
      isLoading = true;
      var userId = await StoreLoginValue.getUserID();
      var token = await StoreLoginValue.getTokenId();
      var headers = {
        "userId": userId.toString(),
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };
      print(headers);
      var response = await http.get(
          Uri.parse("${APIEndPoints.mainUrl}attendance/record"),
          headers: headers);
      var jsonData = json.decode(response.body);
      print("${APIEndPoints.mainUrl}attendance/record");
      print(jsonData);
      print(headers);
      if (response.statusCode == 200) {
        if (jsonData['message'] == "punchIn") {
          isCheckIn = false;
        } else if (jsonData['message'] == "punchOut") {
          isCheckIn = true;
        } else if (response.statusCode == 401) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => const LoginScreen()),
              (route) => false);
        } else {
          isCheckIn = null;
        }
      }
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
