import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../const/app_sreen_size.dart';
import '../../../controller/task_provider.dart';
import '../../../services/date_time_converter.dart';
import '../../../widget/custom_dropdown_widget.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_text_field.dart';

class CreateVisitWidget extends StatefulWidget {
  final int? id;
  const CreateVisitWidget({super.key, this.id});

  @override
  State<CreateVisitWidget> createState() => _CreateVisitWidgetState();
}

class _CreateVisitWidgetState extends State<CreateVisitWidget> {
  String? selectdCustomer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<TaskProvider>(context, listen: false);
    print("1111");
    final taskDetail = provider.findById(widget.id!);
    selectdCustomer = taskDetail.customerId.toString();
    provider.customerNameController.text = taskDetail.customerId.toString();
    provider.statusTypeController.text = taskDetail.status.toString();
    provider.descriptionNameController.text = taskDetail.description.toString();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return SingleChildScrollView(
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
          margin: const EdgeInsets.all(10),
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
                selectedValue: selectdCustomer,
                onChange: widget.id == null
                    ? (val) {
                        print(val);
                      }
                    : null,
              ),
              SizedBox(
                height: ScreenSize.screenSize!.height * 0.03,
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
              SizedBox(
                height: ScreenSize.screenSize!.height * 0.1,
              ),
              CustomElevatedButton(
                  onTap: () async {
                    if (provider.isLoading) {
                    } else {
                      if (provider.customerNameController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Please select a customer");
                      } else {
                        if (widget.id == null) {
                          provider.postTask(
                            createFrom: "Visit",
                            context: context,
                            taskType: null,
                            customerId:
                                int.parse(provider.customerNameController.text),
                            assignTo: null,
                            description:
                                provider.descriptionNameController.text,
                            status: "Visit",
                            feedBack: provider.feedBackController.text,
                            followUpDate: provider.dateSelectController.text,
                          );
                        } else {
                          provider.editTaskApi(
                            taskId: widget.id.toString(),
                            context: context,
                            taskType: null,
                            customerId:
                                int.parse(provider.customerNameController.text),
                            assignTo: null,
                            description:
                                provider.descriptionNameController.text,
                            status: "Visit",
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
    );
  }
}
