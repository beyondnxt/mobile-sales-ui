// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lingam/const/app_sreen_size.dart';
import 'package:lingam/controller/homescreen_provider.dart';
import 'package:lingam/view/loginScreen/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatelessWidget {
  final String name;
  final String email;
  const DrawerScreen({super.key, required this.email, required this.name});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);
    return SafeArea(
      child: Container(
        height: ScreenSize.screenSize!.height,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Column(
          children: [
            Container(
                height: ScreenSize.screenSize!.height * 0.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    )),
                child: Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                    ),
                    title: Text(name),
                    subtitle: Text(email),
                  ),
                )),
            ListTile(
              onTap: () {
                provider.changeCurrentIndex(0);
                Navigator.of(context).pop();
              },
              leading: Icon(
                Icons.task,
                color: Colors.white,
              ),
              title: Text(
                "Task",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                provider.changeCurrentIndex(1);
                Navigator.of(context).pop();
              },
              leading: Icon(
                Icons.document_scanner_outlined,
                color: Colors.white,
              ),
              title: Text(
                "Attendance",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => LoginScreen()),
                    (route) => false);
              },
              leading: Icon(
                Icons.document_scanner_outlined,
                color: Colors.white,
              ),
              title: Text(
                "Log out",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
