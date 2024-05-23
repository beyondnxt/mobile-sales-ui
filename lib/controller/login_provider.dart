import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lingam/const/api_url.dart';
import 'package:lingam/services/store_login_value.dart';

import '../view/homeScreen.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
  bool isLoading = false;

  bool emailValidator(BuildContext context, String email, String password) {
    // String email = emailtextEditingController.textxtrim();

    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      print("Success");
      if(password.isEmpty){
        Fluttertoast.showToast(
          msg: "Please enter a password",
        );
        return false;
      }else{
 loginAuth(context, email, password);
      }

      return true;
    } else {
      print("Sushalt email->> $email");
      Fluttertoast.showToast(
        msg: "Invalid email format",
      );

      return false;
    }
  }

  void showErrorSnackbar(String message) {
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
  }

  Future<void> loginAuth(
      BuildContext context, String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = json.encode({"email": email, "password": password});
      var response = await http.post(
          Uri.parse("${APIEndPoints.mainUrl}auth/signin"),
          body: body,
          headers: headers);
      var jsonData = json.decode(response.body);
      print(jsonData);

      if (response.statusCode == 201) {
        StoreLoginValue.storeLoginDetails(
          email: email,
          passworrd: password,
          userId: jsonData["data"]["userId"].toString(),
          userName: jsonData["data"]["userName"].toString(),
          token: jsonData["data"]["token"].toString(),
        );
        Fluttertoast.showToast(
          msg: "Login Successfully",
        );
        Navigator.of(context).pushNamed(HomeScreen.routeName);

      } else {
        Fluttertoast.showToast(
          msg: jsonData["message"] ?? "Something went wrong",
        );
      }
    } on TimeoutException catch (_) {
      Fluttertoast.showToast(
        msg:
            "Request timed out. Please check your internet connection and try again.",
      );
    } on http.ClientException catch (_) {
      Fluttertoast.showToast(
        msg: "Network error. Please check your internet connection.",
      );
    } on FormatException catch (_) {
      Fluttertoast.showToast(
        msg: "Data format error. Please try again later.",
      );
    } on HttpException catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred: ${e.message}",
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred: ${e.toString()}",
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
