import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lingam/const/api_url.dart';
import 'package:lingam/model/customer_model.dart';
import 'package:lingam/model/lead_type_model.dart';
import 'package:lingam/model/status_type.dart';
import 'package:lingam/model/task_model.dart';
import 'package:lingam/services/date_time_converter.dart';
import 'package:lingam/services/location_services.dart';
import 'package:lingam/services/store_login_value.dart';
import 'package:lingam/view/homeScreen.dart';
import 'package:lingam/view/loginScreen/login_screen.dart';

class TaskProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController leadTypeController = TextEditingController();
  TextEditingController statusTypeController = TextEditingController();
  TextEditingController assignToPersonIDController = TextEditingController();
  TextEditingController assignToPersonController = TextEditingController();

  TextEditingController feedBackController = TextEditingController();
  TextEditingController descriptionNameController = TextEditingController();
  TextEditingController dateSelectController = TextEditingController();
  LocationServices locationServices = LocationServices();
  DateTimeConverter dateTimeConverter = DateTimeConverter();

  List<AllTaskModel> allTaskData = [];
  List<AllTaskModel> searchTaskData = [];
  List<CustomerName> allCustomerName = [];
  List<CustomerName> searchCustomerName = [];

  List<LeadtypeModel> allLeadTypeModel = [
    LeadtypeModel(id: "1", firstName: "Lead"),
    LeadtypeModel(id: "2", firstName: "Call Back"),
    LeadtypeModel(id: "3", firstName: "Service"),
  ];
  List<StatusTypeModel> allStatusTypeModel = [
    StatusTypeModel(id: "1", firstName: "Unassigned"),
    StatusTypeModel(id: "2", firstName: "Assigned"),
    StatusTypeModel(id: "3", firstName: "Completed"),
  ];
  List<StatusTypeModel> allEditStatusTypeModel = [
    StatusTypeModel(id: "2", firstName: "Assigned"),
    StatusTypeModel(id: "3", firstName: "Completed"),
  ];
  AllTaskModel? taskDetailData;
  String errorMessage = "";
  bool isLoading = false;
  bool dropDownLoading = false;
  int currentPage = 1;
  bool isFetchingMore = false;
  String selectedStatus = "assigned";

  Future<dynamic> getAllTaskApi(
      {required BuildContext context,
      required int page,
      required String status}) async {
    String message = "";
    print(page.toString() + "Page");
    if (page == 1) {
      isLoading = true;
    } else {
      isFetchingMore = true;
    }
    notifyListeners();

    try {
      var userId = await StoreLoginValue.getUserID();
      var token = await StoreLoginValue.getTokenId();
      var headers = {
        "userId": userId.toString(),
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };

      var response = await http.get(
          Uri.parse(
              "${APIEndPoints.mainUrl}task?page=${page.toString()}&limit=9&status=$status"),
          headers: headers);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonData["data"];
        if (page == 1) {
          allTaskData = [];
          allTaskData =
              dataList.map((json) => AllTaskModel.fromJson(json)).toList();
        } else {
          allTaskData.addAll(
              dataList.map((json) => AllTaskModel.fromJson(json)).toList());
        }
      } else if (response.statusCode == 401) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const LoginScreen()),
            (route) => false);
      } else {
        message = jsonData["message"];
      }
    } catch (e) {
      message = e.toString();
      print(e.toString());
    } finally {
      isLoading = false;
      isFetchingMore = false;
      errorMessage = message;
      notifyListeners();
    }
  }

  // Future<dynamic> getAllTaskApi(
  //     {required BuildContext context, required String page,}) async {
  //   String message = "";
  //   isLoading = true;
  //   try {
  //     var userId = await StoreLoginValue.getUserID();
  //     var token = await StoreLoginValue.getTokenId();
  //     var headers = {
  //       "userId": userId.toString(),
  //       "Authorization": token.toString(),
  //       "Content-Type": "application/json"
  //     };

  //     print("Getting all");
  //     var response = await http.get(
  //         Uri.parse("${APIEndPoints.mainUrl}task?page=$page&limit=10"),
  //         headers: headers);
  //     var jsonData = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       allTaskData = [];
  //       List<dynamic> dataList = jsonData["data"];
  //       // print(jsonData["data"]);
  //       allTaskData =
  //           dataList.map((json) => AllTaskModel.fromJson(json)).toList();
  //       print(allTaskData);
  //     } else if (response.statusCode == 401) {
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (ctx) => const LoginScreen()),
  //           (route) => false);
  //     } else {
  //       message = jsonData["message"];
  //     }
  //   } catch (e) {
  //     message = e.toString();
  //     print(e.toString());
  //   } finally {
  //     isLoading = false;
  //     errorMessage = message;
  //     notifyListeners();
  //   }
  // }

  Future<dynamic> getAllCustomer() async {
    try {
      isLoading = true;
      var userId = await StoreLoginValue.getUserID();
      var token = await StoreLoginValue.getTokenId();
      var headers = {
        "userId": userId.toString(),
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };
      var response = await http
          .get(Uri.parse("${APIEndPoints.mainUrl}customers"), headers: headers);
      print("${APIEndPoints.mainUrl}customers");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonData["data"];
        print(jsonData["data"]);
        allCustomerName =
            dataList.map((json) => CustomerName.fromJson(json)).toList();
        print(allCustomerName);
      }
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> postTask(
      {required String? taskType,
      required int? customerId,
      required String createFrom,
      required int? assignTo,
      required String? description,
      required String status,
      required String? feedBack,
      required String? followUpDate,
      required BuildContext context}) async {
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
      var body = json.encode({
        "taskType": taskType ?? "",
        "customerId": customerId,
        "assignTo": assignTo,
        "description": description ?? "",
        "status": status,
        "feedBack": [],
        "followUpDate": followUpDate == null || followUpDate == ""
            ? null
            : DateTimeConverter.convertLocalToServerTime(followUpDate),
        "latitude": latitude,
        "longitude": longitude
      });
      print(body);
      var response = await http.post(Uri.parse("${APIEndPoints.mainUrl}task"),
          body: body, headers: headers);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Task Created successfully");
        clearData();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const HomeScreen()),
            (route) => false);
      } else if (response.statusCode == 401) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => LoginScreen()),
            (route) => false);
      } else {
        Fluttertoast.showToast(
            msg: jsonData["message"] ?? "Something went wrong");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> editTaskApi(
      {required String? taskType,
      required String taskId,
      required int? customerId,
      required int? assignTo,
      required String? description,
      required String status,
      required String? feedBack,
      // required String? followUpDate,
      required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      var userId = await StoreLoginValue.getUserID();
      var token = await StoreLoginValue.getTokenId();
      var headers = {
        "userId": userId.toString(),
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };
      var body = json.encode({
        "taskType": taskType ?? "",
        "customerId": customerId,
        "assignTo": assignTo,
        "description": description ?? "",
        "status": status,
        "feedBack": [],
      });
      // "followUpDate": followUpDate == null || followUpDate == ""
      //     ? null
      //     : DateTimeConverter.convertLocalToServerTime(followUpDate),
      print(body);
      print(headers);
      var response = await http.put(
          Uri.parse("${APIEndPoints.mainUrl}task/$taskId"),
          headers: headers,
          body: body);
      var jsonData = json.decode(response.body);
      print("${APIEndPoints.mainUrl}task/$taskId");
      print(jsonData);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Task Updated successfully");
        clearData();

        // await getAllTaskApi(context: context, page: 1, status: "Assigned");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const HomeScreen()),
            (route) => false);
      } else if (response.statusCode == 401) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => LoginScreen()),
            (route) => false);
      } else {
        Fluttertoast.showToast(
            msg: jsonData['message'] ?? "Something went wrong");
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    searchController.clear();
    assignToPersonIDController.clear();
    customerNameController.clear();
    leadTypeController.clear();
    statusTypeController.clear();
    assignToPersonController.clear();
    feedBackController.clear();
    descriptionNameController.clear();
    dateSelectController.clear();
  }

  List<AllTaskModel> searchQuery(String val) {
    searchTaskData = [];
    searchTaskData = allTaskData
        .where((element) =>
            element.userName!.toLowerCase().contains(val.toLowerCase()))
        .toList();
    print(searchTaskData.length.toString() + "---->> Searching...");
    notifyListeners();
    return searchTaskData;
  }

  Color getColorOfStatus(String status) {
    switch (status.toLowerCase()) {
      case 'assigned':
        return Colors.blue.shade200;
      case 'unassigned':
        return Colors.yellow.shade200;
      case 'verified':
        return Colors.green.shade200;
      case 'completed':
        return Colors.orange.shade200;
      case 'visit':
        return Colors.red.shade200;
      default:
        return Colors.grey.shade200;
    }
  }

  AllTaskModel findById(int id) {
    return allTaskData.firstWhere((element) => element.id == id);
  }

  // Status Dropdown Logic
  bool isAssignValue = false;
  void onchangeStatus(String value, String? isInit) async {
    if (isInit != null) {
      isAssignValue = true;
    }

    if (value == "2" && isInit == null) {
      isAssignValue = true;
      assignToPersonController.text = (await StoreLoginValue.getUserName())!;
      assignToPersonIDController.text = (await StoreLoginValue.getUserID())!;
    } else if (value == "1" && isInit == null) {
      isAssignValue = false;
      assignToPersonController.clear();
      assignToPersonIDController.clear();
    }
    // notifyListeners();
  }

  void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  Future<dynamic> searchQueryApi(String query) async {
    try {
      dropDownLoading = true;
      notifyListeners();
      var userId = await StoreLoginValue.getUserID();
      var token = await StoreLoginValue.getTokenId();
      var headers = {
        "userId": userId.toString(),
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };

      var response = await http.get(
          Uri.parse("${APIEndPoints.mainUrl}customers?name=$query"),
          headers: headers);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonData["data"];
        if (dataList.isEmpty) {
        } else {
          searchCustomerName = [];
          print(jsonData["data"]);
          searchCustomerName =
              dataList.map((json) => CustomerName.fromJson(json)).toList();
          print(allCustomerName);
        }
      } else {}
    } catch (e) {
    } finally {
      dropDownLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> getTaskDetailsApi() async {
    String message;
    try {
      isLoading = true;
      notifyListeners();
      var userId = await StoreLoginValue.getUserID();
      var token = await StoreLoginValue.getTokenId();
      var headers = {
        "userId": userId.toString(),
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };

      var response = await http.get(Uri.parse("${APIEndPoints.mainUrl}task/53"),
          headers: headers);
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        taskDetailData = AllTaskModel.fromJson(jsonData);
        notifyListeners();
        return [200, ""];
      } else {
        message = jsonData["message"];
        return [response.statusCode, message];
      }
    } on TimeoutException catch (_) {
      Fluttertoast.showToast(
        msg:
            "Request timed out. Please check your internet connection and try again.",
      );
      message =
          "Request timed out. Please check your internet connection and try again.";
      return [400, message];
    } on http.ClientException catch (_) {
      Fluttertoast.showToast(
        msg: "Network error. Please check your internet connection.",
      );
      message = "Network error. Please check your internet connection.";
      return [400, message];
    } on FormatException catch (_) {
      Fluttertoast.showToast(
        msg: "Data format error. Please try again later.",
      );
      message = "Data format error. Please try again later.";
      return [400, message];
    } on HttpException catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred: ${e.message}",
      );
      message = "An unexpected error occurred: ${e.message}";
      return [400, message];
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred: ${e.toString()}",
      );
      message = "An unexpected error occurred: ${e.toString()}";
      return [400, message];
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<void> addFeedBackApi() async {}
}
