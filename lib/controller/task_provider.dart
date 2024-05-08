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
import 'package:lingam/services/location_services.dart';

class TaskProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController leadTypeController = TextEditingController();
  TextEditingController statusTypeController = TextEditingController();
  TextEditingController assignToPersonController = TextEditingController();
  TextEditingController feedBackController = TextEditingController();
  TextEditingController descriptionNameController = TextEditingController();
  TextEditingController dateSelectController = TextEditingController();
  LocationServices locationServices = LocationServices();

  List<AllTaskModel> allTaskData = [];
  List<AllTaskModel> searchTaskData = [];
  List<CustomerName> allCustomerName = [];

  List<LeadtypeModel> allLeadTypeModel = [
    LeadtypeModel(id: "1", firstName: "Lead"),
    LeadtypeModel(id: "2", firstName: "Call Back"),
    LeadtypeModel(id: "3", firstName: "Service"),
  ];
  List<StatusTypeModel> allStatusTypeModel = [
    StatusTypeModel(id: "1", firstName: "Status"),
    StatusTypeModel(id: "2", firstName: "In progress"),
    StatusTypeModel(id: "3", firstName: "Completed"),
    StatusTypeModel(id: "4", firstName: "Cancel"),
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
      var response = await http.get(Uri.parse("${APIEndPoints.mainUrl}user"));
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonData["data"];
        // print(jsonData["data"]);
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
      {required String taskType,
      required int customerId,
      required int assignTo,
      required String description,
      required String status,
      required String feedBack,
      required String followUpDate,
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
      var body = json.encode({
        "taskType": taskType,
        "customerId": customerId,
        "assignTo": assignTo,
        "description": description,
        "status": status,
        "feedBack": feedBack,
        "followUpDate": convertLocalToServerTime(followUpDate),
        "latitude": latitude,
        "longitude": longitude
      });
      print(body);
      var response =
          await http.post(Uri.parse("${APIEndPoints.mainUrl}task"), body: body);
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

  String convertLocalToServerTime(String localTime) {
    // Convert local time to UTC
    DateTime utcTime = DateTime.parse(localTime).toUtc();

    // Format UTC time to send to the server
    String formattedUtcTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(utcTime);

    return formattedUtcTime;
  }

  void clearData() {
    searchController.clear();
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
    print(searchTaskData.length.toString()+ "---->> Searching...");
    notifyListeners();
    return searchTaskData;
  }
}
