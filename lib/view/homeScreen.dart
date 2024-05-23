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
    super.initState();
    // Any non-context dependent initialization can still be done here
    getUserEmailAndName();
     final provider = Provider.of<HomeScreenProvider>(context, listen: false);
    provider.currentPage = 0; // Set provider value here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access your provider or inherited widget here
    print("kkkkkk");

  }

  Future<void> getUserEmailAndName() async {
    userEmail = await StoreLoginValue.getUserEmail() ?? "";
    userName = await StoreLoginValue.getUserName() ?? "";
    setState(() {}); // Make sure to update the state
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
