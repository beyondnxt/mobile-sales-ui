import 'package:flutter/material.dart';
import 'package:lingam/view/attendanceScreen/attendance_screen.dart';
import 'package:lingam/view/taskScreen/all_task_screen.dart';

class HomeScreenProvider with ChangeNotifier {
  int currentPage = 0;
  List<Widget> allScreenInHome = [MyTaskScreen(), AttendanceScreen()];

  List<String> appBarName = ["Task", "Attendance", ];

  void changeCurrentIndex(int val) {
    currentPage = val;
    print(currentPage);
    notifyListeners();
  }
}
