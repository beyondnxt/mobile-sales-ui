import 'package:flutter/material.dart';

import '../const/app_sreen_size.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  const CustomElevatedButton({super.key,required this.onTap,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.screenSize!.height * 0.07,
      width: ScreenSize.screenSize!.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: onTap,
          child:  Text(
            title,
            style:const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }
}
