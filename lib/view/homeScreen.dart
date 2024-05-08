import 'package:flutter/material.dart';
import 'package:lingam/controller/homescreen_provider.dart';
import 'package:lingam/services/store_login_value.dart';
import 'package:provider/provider.dart';

import '../const/images.dart';
import 'drawerScreen/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String userName = "";
  String userEmail = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserdetail();
  }

  Future<void> getUserdetail() async {
    userEmail = await StoreLoginValue.getUserEmail() ?? "";
    userName = await StoreLoginValue.getUserName() ?? "";
    setState(() {
      
    });
    print("User name  $userName");
    print("User Email $userEmail");
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Image.asset(
              CustomImagePath.draweIcons,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(provider.appBarName[provider.currentPage]),
      ),
      drawer: Drawer(
        child: DrawerScreen(
          email: userEmail,
          name: userName,
        ),
      ),
      body: provider.allScreenInHome[provider.currentPage],
    );
  }
}
