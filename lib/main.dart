import 'package:flutter/material.dart';
import 'package:lingam/const/all_provider.dart';
import 'package:lingam/const/custom_routes.dart';
import 'package:lingam/const/theme_data.dart';
import 'package:lingam/view/loginScreen/login_screen.dart';
import 'package:provider/provider.dart';

import 'const/app_sreen_size.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSize.setScreenSize(context);
    CustomThemeData customThemeData = CustomThemeData(context);
    return MultiProvider(
      providers: AllProvider.allprovider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lingam & Co',
        theme: customThemeData.themeData,
        home:const LoginScreen(),
        onGenerateRoute: CustomRoutes.generateRoute,
      ),
    );
  }
}
