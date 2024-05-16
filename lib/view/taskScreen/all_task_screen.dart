import 'package:flutter/material.dart';
import 'package:lingam/const/app_sreen_size.dart';
import 'package:lingam/const/colors.dart';
import 'package:lingam/controller/task_provider.dart';
import 'package:lingam/services/date_time_converter.dart';
import 'package:lingam/view/taskScreen/task_details_screen.dart';
import 'package:lingam/widget/loading_screen.dart';
import 'package:provider/provider.dart';

import 'add_task_screen.dart';

class MyTaskScreen extends StatefulWidget {
  static const routeName = "task_screen";
  const MyTaskScreen({super.key});

  @override
  State<MyTaskScreen> createState() => _MyTaskScreenState();
}

class _MyTaskScreenState extends State<MyTaskScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).getAllTaskApi();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: const EdgeInsets.all(15.0),
      //     child: GestureDetector(
      //       onTap: () {
      //         _scaffoldKey.currentState!.openDrawer();
      //       },
      //       child: Image.asset(
      //         CustomImagePath.draweIcons,
      //       ),
      //     ),
      //   ),
      //   centerTitle: true,
      //   title: const Text("Task"),
      // ),

      body: Container(
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
              margin: const EdgeInsets.all(10),
              height: ScreenSize.screenSize!.height * 0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300),
              child: TextFormField(
                controller: taskProvider.searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    prefixIcon: const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    hintText: "Search here...",
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(4),
                      height: ScreenSize.screenSize!.height * 0.06,
                      width: ScreenSize.screenSize!.width * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.orangeColor,
                      ),
                      child: const Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                    )),
                onChanged: (val) {
                  taskProvider.searchQuery(val);
                  print(taskProvider.searchController.text.isNotEmpty);
                  print(taskProvider.searchTaskData);
                },
              ),
            ),
            taskProvider.isLoading
                ? const LoadingScreen()
                : taskProvider.allTaskData.isEmpty
                    ? const Flexible(
                        child: Center(
                          child: Text("No data found."),
                        ),
                      )
                    : Flexible(
                        child: taskProvider.searchController.text.isNotEmpty &&
                                taskProvider.searchTaskData.isNotEmpty
                            ? ListView.separated(
                              physics:
                                  const AlwaysScrollableScrollPhysics(),
                              itemCount: taskProvider.searchTaskData.length,
                              itemBuilder: (ctx, index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                TaskDetailsScreen(
                                                    id: taskProvider
                                                        .searchTaskData[
                                                            index]
                                                        .id!)));
                                  },
                                  title: Text(
                                      "Task ID - #${taskProvider.searchTaskData[index].id}"),
                                  subtitle: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Text("Status"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height:
                                            ScreenSize.screenSize!.height *
                                                0.035,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: taskProvider
                                                .getColorOfStatus(
                                                    taskProvider
                                                            .searchTaskData[
                                                                index]
                                                            .status ??
                                                        "")),
                                        child: Text(taskProvider
                                                .searchTaskData[index]
                                                .status ??
                                            ""),
                                      )
                                    ],
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      // Handle call action here
                                    },
                                    child: Container(
                                      child: Text(DateTimeConverter
                                          .convertServerTimeToLocal(
                                              taskProvider
                                                  .searchTaskData[index]
                                                  .createdOn
                                                  .toString())),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Divider(
                                    color: Colors.grey.shade300,
                                    height: 10,
                                  ),
                                );
                              },
                            )
                            : taskProvider.searchController.text.isNotEmpty &&
                                    taskProvider.searchTaskData.isEmpty
                                ? Center(
                                    child: Text("No data found."),
                                  )
                                : RefreshIndicator(
                                  onRefresh: ()async{
                                    await taskProvider.getAllTaskApi();
                                  },
                                  child: ListView.separated(
                                      itemCount: taskProvider.allTaskData.length,
                                       physics:
                                      const AlwaysScrollableScrollPhysics(),
                                      itemBuilder: (ctx, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        TaskDetailsScreen(
                                                            id: taskProvider
                                                                .allTaskData[
                                                                    index]
                                                                .id!)));
                                          },
                                          title: Text(
                                              "Task ID - #${taskProvider.allTaskData[index].id}"),
                                          subtitle: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("Status"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: ScreenSize
                                                        .screenSize!.height *
                                                    0.035,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    color: taskProvider
                                                        .getColorOfStatus(
                                                            taskProvider
                                                                    .allTaskData[
                                                                        index]
                                                                    .status ??
                                                                "")),
                                                child: Text(taskProvider
                                                        .allTaskData[index]
                                                        .status ??
                                                    ""),
                                              )
                                            ],
                                          ),
                                          trailing: GestureDetector(
                                            onTap: () {
                                              // Handle call action here
                                            },
                                            child: Container(
                                              child: Text(DateTimeConverter
                                                  .convertServerTimeToLocal(
                                                      taskProvider
                                                          .allTaskData[index]
                                                          .createdOn
                                                          .toString())),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (ctx, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Divider(
                                            color: Colors.grey.shade300,
                                            height: 10,
                                          ),
                                        );
                                      },
                                    ),
                                ),
                      ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskScreen.routeName);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
