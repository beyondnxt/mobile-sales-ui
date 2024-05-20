import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lingam/controller/task_provider.dart';
import 'package:lingam/services/date_time_converter.dart';
import 'package:lingam/view/taskScreen/widget/create_task_widget.dart';
import 'package:lingam/widget/custom_date_picker_widget.dart';
import 'package:lingam/widget/custom_dropdown_widget.dart';
import 'package:lingam/widget/custom_elevated_button.dart';
import 'package:lingam/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../const/app_sreen_size.dart';
import 'widget/create_visit_widget.dart';

class AddTaskScreen extends StatefulWidget {
  final int? id;
  final String? status;
  static const routeName = "add_task_screen";
  const AddTaskScreen({super.key, required this.id, this.status});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<TaskProvider>(context, listen: false);
    // provider.getAllCustomer();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
     print("Scrolling started 1");
      if (widget.id != null) {
        print('nope!');
          print("Scrolling started 2");
        if (widget.status == "Visit") {
            print("Scrolling started 3");
          print(widget.status);
          print(_controller!.index);
          setState(() {
            _controller!.index = 1;
          });
        } else if (widget.status != null && widget.status != "Visit") {
            print("Scrolling started 4");
          setState(() {
            _controller!.index = 0;
          });
        }
      }

    _controller!.addListener(() {

      if (widget.id != null) {

        if (widget.status == "Visit") {

          setState(() {
            _controller!.index = 1;
          });
        } else if (widget.status != null && widget.status != "Visit") {

          setState(() {
            _controller!.index = 0;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                provider.clearData();
                print("nav back");
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text("Add Task"),
        ),
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
                height: ScreenSize.screenSize!.height * 0.06,
                child: TabBar(
                  isScrollable: false,
                  controller: _controller,
                  onTap: (val) {
                    print('----${_controller!.index}');
                    if (widget.id == null) {
                      provider.clearData();
                    }
                  },
                  tabs: [
                    Tab(text: 'Task'),
                    Tab(text: 'Visit'),
                  ],
                ),
              ),
              Flexible(
                child: TabBarView(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CreateTaskWidget(
                      id: widget.id,
                    ),
                    CreateVisitWidget(id: widget.id,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
