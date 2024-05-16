import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lingam/const/app_sreen_size.dart';
import 'package:lingam/controller/task_provider.dart';
import 'package:lingam/view/taskScreen/add_task_screen.dart';
import 'package:provider/provider.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int id;
  const TaskDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final detailTask = taskProvider.findById(id);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        leading: detailTask.status == "Unassigned" ||
                detailTask.status == "Assigned" ||
                detailTask.status == "Visit"
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))
            : Container(),
        title: Text("Task - #${detailTask.id.toString()}"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddTaskScreen(
                          id: detailTask.id!,
                          status: detailTask.status,
                        )));
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ))
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
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    titleAndSubtitle("Task Type", "${detailTask.taskType}"),
                    titleAndSubtitle(
                        "Customer Name", "${detailTask.customerName}"),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    titleAndSubtitle(
                        "Assign To ", "${detailTask.assignToName}"),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Status"),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade200,
                                    borderRadius: BorderRadius.circular(10)),
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
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 20),
                    ),
                    Text(
                      "${detailTask.description}",
                      style: TextStyle(color: Colors.black, fontSize: 17),
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
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 20),
                    ),
                    if (detailTask.feedBack != null)
                      ...List.generate(
                          detailTask.feedBack!.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  detailTask.feedBack![index].feedback ?? "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                              ))
                  ],
                ),
              )
            ],
          ),
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
}
