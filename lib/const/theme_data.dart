import 'package:flutter/material.dart';

class CustomThemeData {
  final BuildContext context; // Context as an instance member

  CustomThemeData(this.context);

  ThemeData get themeData {
    return ThemeData(
      fontFamily: "Urbanist",
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      appBarTheme:const AppBarTheme(
          backgroundColor: Color(0xff1C92C4),
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      useMaterial3: true,
      primaryColor: const Color(0xff1C92C4),
      textTheme: const TextTheme(
          headlineMedium: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle:
              MaterialStateProperty.all(const TextStyle(color: Colors.white)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xff1C92C4),
          ),
        ),
      ),
    );
  }
}
