import 'package:flutter/material.dart';
import 'package:lingam/view/homeScreen.dart';
import 'package:lingam/view/loginScreen/login_screen.dart';
import 'package:lingam/view/taskScreen/add_task_screen.dart';
import 'package:lingam/view/taskScreen/all_task_screen.dart';

class CustomRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case MyTaskScreen.routeName:
        return MaterialPageRoute(builder: (_) => const MyTaskScreen());
      case AddTaskScreen.routeName:
        return MaterialPageRoute(builder: (_) => const AddTaskScreen());
        case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
