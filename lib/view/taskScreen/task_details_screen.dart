import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lingam/const/app_sreen_size.dart';
import 'package:lingam/controller/task_provider.dart';
import 'package:lingam/model/task_model.dart';
import 'package:lingam/services/store_login_value.dart';
import 'package:lingam/view/taskScreen/add_task_screen.dart';
import 'package:lingam/widget/custom_elevated_button.dart';
import 'package:lingam/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

class TaskDetailsScreen extends StatefulWidget {
  final int id;
  const TaskDetailsScreen({super.key, required this.id});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      Provider.of<TaskProvider>(context, listen: false)
          .getTaskDetailsApi(widget.id.toString());
    });
  }

  List<FeedBack> allFeedBack = [];

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final detailTask = taskProvider.taskDetailData;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: taskProvider.isLoading
          ? AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            )
          : AppBar(
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              title: Text("Task - #${widget.id.toString()}"),
              actions: [
                detailTask?.status == "Unassigned" ||
                        detailTask?.status == "Assigned" ||
                        detailTask?.status == "Visit"
                    ? taskProvider.isLoading
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => AddTaskScreen(
                                        id: detailTask?.id!,
                                        status: detailTask?.status,
                                      )));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ))
                    : Container(),
                detailTask?.status == "Visit"
                    ? IconButton(
                        onPressed: () {
                          showConfirmDialog(context);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ))
                    : Container()
              ],
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
          child: taskProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : taskProvider.taskDetailData == null
                  ? Center(
                      child: Text(taskProvider.errorMessage),
                    )
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              detailTask!.status!.toLowerCase() == "visit"
                                  ? Container()
                                  : titleAndSubtitle(
                                      "Task Type", "${detailTask!.taskType}"),
                              titleAndSubtitle("Customer Name",
                                  "${detailTask.customerName}"),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              detailTask!.status!.toLowerCase() == "visit"
                                  ? Container()
                                  : titleAndSubtitle("Assign To ",
                                      "${detailTask.assignToName}"),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Status"),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.orange.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text("${detailTask.status}"),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          width: ScreenSize.screenSize!.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 20),
                              ),
                              Text(
                                "${detailTask.description}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          width: ScreenSize.screenSize!.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Feedback",
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 20),
                              ),
                              if (detailTask.feedBack != null)
                                ...List.generate(
                                    detailTask.feedBack!.length,
                                    (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            detailTask.feedBack![index]
                                                    .feedback ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                        ))
                            ],
                          ),
                        )
                      ],
                    ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showBottomModelSheet();
        },
        child: Container(
          height: ScreenSize.screenSize!.height * 0.06,
          width: ScreenSize.screenSize!.width * 0.3,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
            "Add Feedback",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  Widget titleAndSubtitle(
    String title,
    String subtitle,
  ) {
    return Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 20),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ));
  }

  Future showBottomModelSheet() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (BuildContext context) {
        return Container(
          height: ScreenSize.screenSize!.height * 0.55,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomTextFormField(
                    height: ScreenSize.screenSize!.height * 0.1,
                    maxLine: 3,
                    hintText: "Enter Feedback",
                    lableText: "Feedback",
                    controller: taskProvider.feedBackController,
                    prefixIcon: null,
                    suffixIcons: null,
                    textInputType: TextInputType.streetAddress),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: CustomElevatedButton(
                      onTap: () async {
                        if (taskProvider.feedBackController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Please enter feedback");
                        } else {
                          final taskProvider =
                              Provider.of<TaskProvider>(context, listen: false);
                          final detailTask = taskProvider.taskDetailData;
                          var userId = await StoreLoginValue.getUserID();
                          var userName = await StoreLoginValue.getUserName();
                          var createdDateTime = _formatDateTime(DateTime.now());
                          allFeedBack = detailTask!.feedBack!;

                          allFeedBack.add(FeedBack(
                              createdBy: userId,
                              createdDate: createdDateTime,
                              createdByName: userName,
                              feedback: taskProvider.feedBackController.text));

                          print(allFeedBack);

                          taskProvider.editTaskApi(
                              taskType: detailTask.taskType,
                              taskId: widget.id.toString(),
                              customerId: detailTask.customerId,
                              assignTo: detailTask.assignTo,
                              description: detailTask.description,
                              status: detailTask.status!,
                              feedBack: allFeedBack,
                              context: context);
                          Navigator.of(context).pop();
                        }
                      },
                      title: "Submit Feedback")),
              SizedBox(
                height: ScreenSize.screenSize!.height * 0.4,
              )
            ],
          ),
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'");
    String formatted = formatter.format(dateTime.toUtc());
    return formatted;
  }

  void showConfirmDialog(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Are you sure you want to delete this Visit?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Handle the deletion logic here

                provider.deleteTaskApi(widget.id.toString(), context);
              },
            ),
          ],
        );
      },
    );
  }
}
