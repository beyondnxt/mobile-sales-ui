import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/utils/auto_router_setup/auto_router.gr.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/values/styles.dart';


class CustomTextButton extends StatelessWidget {
  final String title;
  final EdgeInsets margin;
  final void Function() onPressed;

  const CustomTextButton({
    this.title = '',
    this.margin = EdgeInsets.zero, required this.onPressed
  });

  @override
  Widget build(BuildContext context) {   
     AppConfigurations appConfigurations = AppConfigurations();

    return Container(
      height: 44  ,
      width: double.infinity,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          title,
          style: poppinsRegular.copyWith(
                fontSize: 14.w,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}