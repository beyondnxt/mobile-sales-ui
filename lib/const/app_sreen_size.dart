import 'package:flutter/material.dart';

class ScreenSize {
  static Size? _size;

  static void setScreenSize(BuildContext context) {
    _size = MediaQuery.of(context).size;
  }

  static Size? get screenSize => _size;
}