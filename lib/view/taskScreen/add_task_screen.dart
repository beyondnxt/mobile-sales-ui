import 'package:flutter/material.dart';
import 'package:lingam/controller/task_provider.dart';
import 'package:lingam/widget/custom_date_picker_widget.dart';
import 'package:lingam/widget/custom_dropdown_widget.dart';
import 'package:lingam/widget/custom_elevated_button.dart';
import 'package:lingam/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../const/app_sreen_size.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = "add_task_screen";
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).getAllCustomer();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text("Add Task"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: ScreenSize.screenSize!.width,
          height: ScreenSize.screenSize!.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.03,
                ),
                CustomDropdownContainer(
                  controller: provider.customerNameController,
                  hintText: "Select Customer",
                  lableText: "Customer Name",
                  dropDownValue: provider.allCustomerName,
                ),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                CustomDropdownContainer(
                  controller: provider.leadTypeController,
                  hintText: "Select Lead Type",
                  lableText: "Lead Type",
                  dropDownValue: provider.allLeadTypeModel,
                ),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                CustomDropdownContainer(
                  controller: provider.statusTypeController,
                  hintText: "Status",
                  lableText: "Status",
                  dropDownValue: provider.allStatusTypeModel,
                ),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                CustomDropdownContainer(
                  controller: provider.assignToPersonController,
                  hintText: "Assign To Person",
                  lableText: "Assign To Person",
                  dropDownValue: provider.allCustomerName,
                ),
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
                    hintText: "Enter Description",
                    lableText: "Description",
                    controller: provider.descriptionNameController,
                    prefixIcon: null,
                    suffixIcons: null,
                    textInputType: TextInputType.streetAddress),
                SizedBox(
                  height: ScreenSize.screenSize!.height * 0.02,
                ),
                CustomTextFormField(
                    hintText: "Enter Feedback",
                    lableText: "Feedback",
                    controller: provider.feedBackController,
                    prefixIcon: null,
                    suffixIcons: null,
                    textInputType: TextInputType.streetAddress),
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
                  height: ScreenSize.screenSize!.height * 0.1,
                ),
                CustomElevatedButton(
                    onTap: () async {
                     if( provider.isLoading){

                     }else{
                      provider.postTask(
                        context: context,
                          taskType: provider.allLeadTypeModel.firstWhere((element) => element.id == provider.leadTypeController.text).firstName,
                          customerId: int.parse(provider.customerNameController.text),
                          assignTo: int.parse(provider.assignToPersonController.text),
                          description: provider.descriptionNameController.text,
                          status: provider.allStatusTypeModel.firstWhere((element) => element.id == provider.statusTypeController.text).firstName,
                          feedBack: provider.feedBackController.text,
                          followUpDate: provider.convertLocalToServerTime(provider.dateSelectController.text),
                          );
                     }

                    },
                    title: provider.isLoading? "Loading":"Submit")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
