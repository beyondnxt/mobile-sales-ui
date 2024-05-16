import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lingam/const/api_url.dart';
import 'package:lingam/model/customer_model.dart';
import 'package:lingam/model/lead_type_model.dart';
import 'package:lingam/model/status_type.dart';
import 'package:lingam/model/task_model.dart';
import 'package:lingam/services/date_time_converter.dart';
import 'package:lingam/services/location_services.dart';
import 'package:lingam/services/store_login_value.dart';
import 'package:lingam/view/homeScreen.dart';

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

  String errorMessage = "";
  bool isLoading = false;

  Future<dynamic> getAllTaskApi() async {
    String message = "";
    try {
      isLoading = true;
      print("Getting all");
      var response = await http.get(Uri.parse("${APIEndPoints.mainUrl}task"));
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        allTaskData = [];
        List<dynamic> dataList = jsonData["data"];
        // print(jsonData["data"]);
        allTaskData =
            dataList.map((json) => AllTaskModel.fromJson(json)).toList();
        print(allTaskData);
      } else {
        message = jsonData["message"];
      }
    } catch (e) {
      message = e.toString();
      print(e.toString());
    } finally {
      isLoading = false;
      errorMessage = message;
      notifyListeners();
    }
  }

  Future<dynamic> getAllCustomer() async {
    try {
      isLoading = true;
      var headers = {};
      var response =
          await http.get(Uri.parse("${APIEndPoints.mainUrl}customers"));
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
      await locationServices.determinePosition().then((value) {
        print(value);
        latitude = value.latitude;
        longitude = value.longitude;
      });
      var userId = await StoreLoginValue.getUserID();
      var headers = {
        'userId': userId.toString(),
        'Content-Type': 'application/json'
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
        await getAllTaskApi();
        Navigator.of(context).pop();
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
      var headers = {
        'userId': userId.toString(),
        'Content-Type': 'application/json'
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
        await getAllTaskApi();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const HomeScreen()),
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
    notifyListeners();
  }

  void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
