import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lingam/model/task_model.dart';
import 'package:lingam/services/date_time_converter.dart';
import 'package:lingam/view/taskScreen/widget/create_search_dropdown.dart';
import 'package:lingam/widget/loading_screen.dart';
import 'package:provider/provider.dart';

import '../../../const/app_sreen_size.dart';
import '../../../controller/task_provider.dart';
import '../../../widget/custom_date_picker_widget.dart';
import '../../../widget/custom_dropdown_widget.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_text_field.dart';

class CreateTaskWidget extends StatefulWidget {
  final int? id;

  const CreateTaskWidget({
    super.key,
    this.id,
  });

  @override
  State<CreateTaskWidget> createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  AllTaskModel? allTaskModel;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<TaskProvider>(context, listen: false);
    if (widget.id != null) {
      print("Page with customer id");
      startPage(widget.id!);
    } else {
        print("Page without customer id");
      provider.getAllCustomer().then((value) {
        print(widget.id.toString() + "---->>");
        if (widget.id != null) {
          startPage(widget.id!).then((value) {});
        }
      });
    }
  }

  String? selectedTask;
  String? selectdCustomer;
  String? selectedStatus;
  String? customerName;

  Future<void> startPage(int id) async {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    print("1111");

    final taskDetail = provider.findById(widget.id!);
    selectdCustomer = taskDetail.customerId.toString();
    customerName = taskDetail.customerName;
    print("2222 ${taskDetail.taskType}-");
    selectedTask = provider.allLeadTypeModel
        .firstWhere((element) => element.firstName == taskDetail.taskType)
        .id;
    print(selectedTask);
    print("3333");
    print(taskDetail.customerId.toString());
    print(taskDetail.status);

    print("task custmer name --$selectdCustomer");
    print("task custmer id --$customerName");
    selectedStatus = provider.allStatusTypeModel
        .firstWhere((element) => element.firstName == taskDetail.status)
        .id;
    print(selectdCustomer);
    print(selectedStatus);
    print("4444");
    provider.customerNameController.text = taskDetail.customerId.toString();
    print("5555");
    provider.leadTypeController.text = taskDetail.taskType.toString();
    print("6666");
    provider.statusTypeController.text = taskDetail.status.toString();

    if (taskDetail.assignTo != null) {
      print("7777");
      provider.onchangeStatus(taskDetail.status!, "");
      provider.assignToPersonController.text =
          taskDetail.assignToName.toString();

      provider.assignToPersonIDController.text = taskDetail.assignTo.toString();
    }
    provider.descriptionNameController.text = taskDetail.description.toString();

    if (taskDetail.followUpDate != null) {
      print("8888");
      provider.dateSelectController.text =
          DateFormat('yyyy-MM-dd').format(taskDetail.followUpDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    if (widget.id != null) {
      allTaskModel = provider.findById(widget.id!);
    }
    // final taskDetail = provider.findById(widget.id);
    return Container(
      width: ScreenSize.screenSize!.width,
      height: ScreenSize.screenSize!.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.03,
                ),
                SearchableDropDown(
                  controller: provider.customerNameController,
                  customerId: allTaskModel?.customerId,
                  initialValue: allTaskModel?.customerName.toString(),
                ),
                // CustomDropdownContainer(
                //   controller: provider.customerNameController,
                //   hintText: "Select Customer",
                //   lableText: "Customer Name",
                //   dropDownValue: provider.allCustomerName,
                //   selectedValue: selectdCustomer,
                //   onChange: widget.id == null
                //       ? (val) {
                //           print(val);
                //         }
                //       : null,
                // ),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                CustomDropdownContainer(
                  controller: provider.leadTypeController,
                  hintText: "Select Task Type",
                  lableText: "Task Type",
                  dropDownValue: provider.allLeadTypeModel,
                  selectedValue: selectedTask,
                  onChange: widget.id == null ? (val) {} : null,
                ),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                CustomDropdownContainer(
                  controller: provider.statusTypeController,
                  hintText: "Status",
                  lableText: "Status",
                  selectedValue: selectedStatus,
                  dropDownValue: selectedStatus == "2"
                      ? provider.allEditStatusTypeModel
                      : provider.allStatusTypeModel,
                  onChange: (val) {
                    provider.onchangeStatus(val, null);
                  },
                ),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                provider.isAssignValue
                    ? CustomTextFormField(
                        readOnly: true,
                        hintText: "Enter Assign person",
                        lableText: "Assign person",
                        controller: provider.assignToPersonController,
                        prefixIcon: null,
                        suffixIcons: null,
                        textInputType: TextInputType.streetAddress)
                    : Container(),
                // SizedBox(
                //   height: ScreenSize.screenSize!.height * 0.02,
                // ),
                // CustomTextFormField(
                //     hintText: "Enter Company Name",
                //     lableText: "Company Name",
                //     controller: provider.companyNameController,
                //     prefixIcon: null,
                //     suffixIcons: null,
                //     textInputType: TextInputType.streetAddress),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                // CustomTextFormField(
                //     hintText: "Enter Street",
                //     lableText: "Street",
                //     controller: provider.streetNameController,
                //     prefixIcon: null,
                //     suffixIcons: null,
                //     textInputType: TextInputType.streetAddress),
                // SizedBox(
                //   height: ScreenSize.screenSize!.height * 0.02,
                // ),
                // CustomTextFormField(
                //     hintText: "Enter Village/City",
                //     lableText: "Village/City",
                //     controller: provider.cityNameController,
                //     prefixIcon: null,
                //     suffixIcons: null,
                //     textInputType: TextInputType.streetAddress),
                // SizedBox(
                //   height: ScreenSize.screenSize!.height * 0.02,
                // ),
                // CustomTextFormField(
                //     hintText: "Enter Landmark",
                //     lableText: "Landmark",
                //     controller: provider.landMarkNameController,
                //     prefixIcon: null,
                //     suffixIcons: null,
                //     textInputType: TextInputType.streetAddress),
                // SizedBox(
                //   height: ScreenSize.screenSize!.height * 0.02,
                // ),
                CustomDatePickerWidget(),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                CustomTextFormField(
                    height: ScreenSize.screenSize!.height * 0.1,
                    maxLine: 3,
                    hintText: "Enter Description",
                    lableText: "Description",
                    controller: provider.descriptionNameController,
                    prefixIcon: null,
                    suffixIcons: null,
                    textInputType: TextInputType.streetAddress),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                widget.id == null
                    ? CustomTextFormField(
                        height: ScreenSize.screenSize!.height * 0.1,
                        maxLine: 3,
                        hintText: "Enter Feedback",
                        lableText: "Feedback",
                        controller: provider.feedBackController,
                        prefixIcon: null,
                        suffixIcons: null,
                        textInputType: TextInputType.streetAddress)
                    : Container(),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                // CustomDropdownContainer(
                //   controller: provider.assignToPersonController,
                //   hintText: "Assign To Person",
                //   lableText: "Assign To Person",
                // ),
                // SizedBox(
                //   height: ScreenSize.screenSize!.height * 0.02,
                // ),

                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.07,
                ),
                provider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomElevatedButton(
                        onTap: () async {
                          if (provider.isLoading) {
                          } else {
                            if (provider.customerNameController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please select a customer");
                            } else if (provider
                                .leadTypeController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please select a Task Type");
                            } else if (provider
                                .statusTypeController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please select a Status");
                            } else if (provider
                                .descriptionNameController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please enter a description");
                            } else if (provider
                                .dateSelectController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please select an follow up date");
                            } else {
                              if (widget.id == null) {
                                print(provider.statusTypeController.text +
                                    " is not available");
                                print(provider.customerNameController.text);
                                print(provider.assignToPersonIDController.text);
                                provider.postTask(
                                  createFrom: "task",
                                  context: context,
                                  taskType: provider.allLeadTypeModel
                                      .firstWhere((element) =>
                                          element.id ==
                                          provider.leadTypeController.text)
                                      .firstName,
                                  customerId: int.parse(
                                      provider.customerNameController.text),
                                  assignTo: provider.assignToPersonIDController
                                          .text.isEmpty
                                      ? null
                                      : int.parse(provider
                                          .assignToPersonIDController.text),
                                  description:
                                      provider.descriptionNameController.text,
                                  status: provider.allStatusTypeModel
                                      .firstWhere((element) =>
                                          element.id ==
                                          provider.statusTypeController.text)
                                      .firstName,
                                  feedBack: provider.feedBackController.text,
                                  followUpDate:
                                      provider.dateSelectController.text,
                                );
                              } else {
                                final provider = Provider.of<TaskProvider>(
                                    context,
                                    listen: false);
                                final taskDetail =
                                    provider.findById(widget.id!);
                                var status = "";
                                print("Edit started");
                                print(provider.statusTypeController.text);

                                if (taskDetail.status == "Assigned") {
                                  bool val = containsAlphabet(
                                      provider.statusTypeController.text);
                                  if (val == true) {
                                    status = provider.allEditStatusTypeModel
                                        .firstWhere((element) =>
                                            element.firstName ==
                                            provider.statusTypeController.text)
                                        .firstName;
                                  } else {
                                    status = provider.allEditStatusTypeModel
                                        .firstWhere((element) =>
                                            element.id ==
                                            provider.statusTypeController.text)
                                        .firstName;
                                  }
                                  print(
                                      "-----${provider.statusTypeController.text}");
                                } else {
                                  bool val = containsAlphabet(
                                      provider.statusTypeController.text);
                                  print(val.toString() + "--- value data");
                                  if (val == true) {
                                    status = provider.allStatusTypeModel
                                        .firstWhere((element) =>
                                            element.firstName ==
                                            provider.statusTypeController.text)
                                        .firstName;
                                    print(status);
                                  } else {
                                    status = provider.allStatusTypeModel
                                        .firstWhere((element) =>
                                            element.id ==
                                            provider.statusTypeController.text)
                                        .firstName;
                                    print(status);
                                  }
                                }
                                // print("----");
                                // print(widget.id.toString());
                                // print(provider.allLeadTypeModel
                                //     .firstWhere((element) =>
                                //         element.firstName ==
                                //         provider.leadTypeController.text)
                                //     .firstName);
                                // print(provider.customerNameController.text);
                                // print(provider.assignToPersonIDController.text);
                                // print(provider.allStatusTypeModel
                                //     .firstWhere((element) =>
                                //         element.id ==
                                //         provider.statusTypeController.text)
                                //     .firstName);
                                // print(provider.customerNameController.text);
                                // print(provider.assignToPersonIDController.text);
                                provider.editTaskApi(
                                  taskId: widget.id.toString(),
                                  context: context,
                                  taskType: provider.leadTypeController.text,
                                  customerId: int.parse(
                                      provider.customerNameController.text),
                                  assignTo: provider.assignToPersonIDController
                                          .text.isEmpty
                                      ? null
                                      : int.parse(provider
                                          .assignToPersonIDController.text),
                                  description:
                                      provider.descriptionNameController.text,
                                  status: status,
                                  feedBack: provider.feedBackController.text,
                                );
                              }
                            }
                          }
                        },
                        title: provider.isLoading ? "Loading" : "Submit")
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool containsAlphabet(String text) {
    // Regular expression to match alphabets
    RegExp regExp =
        RegExp(r'[a-zA-Z]'); // Matches both lowercase and uppercase alphabets

    // Check if the text contains any alphabets
    return regExp.hasMatch(text);
  }
}
