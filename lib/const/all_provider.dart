import 'package:lingam/controller/attendance_provider.dart';
import 'package:lingam/controller/homescreen_provider.dart';
import 'package:lingam/controller/login_provider.dart';
import 'package:lingam/controller/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AllProvider {
 static  List<SingleChildWidget> allprovider = [
   ChangeNotifierProvider(create: (_)=> LoginProvider()),
   ChangeNotifierProvider(create: (_)=> TaskProvider()),
   ChangeNotifierProvider(create: (_)=> HomeScreenProvider()),
   ChangeNotifierProvider(create: (_)=> AttendanceProvider())
  ];
}
