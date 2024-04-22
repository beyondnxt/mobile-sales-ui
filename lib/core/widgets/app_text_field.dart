import 'package:flutter/material.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/values/styles.dart';

class AppTextField extends StatelessWidget {
  final AppConfigurations appConfigurations;
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? maxLines;
  const AppTextField(
      {super.key,
      required this.appConfigurations,
      required this.controller,
      this.title,
      this.hintText,
      this.keyboardType,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: poppinsBold.copyWith(
              color: appConfigurations.appTheme.primaryColor,
              fontSize: 15.w,
            ),
          ),
          SizedBox(
            height: 5.h,
          )
        ],
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: 14.h),
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(
                8.w,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(.5),
                ),
                borderRadius: BorderRadius.circular(10.w),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(.5)),
                borderRadius: BorderRadius.circular(10.w),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(.5),
                ),
                borderRadius: BorderRadius.circular(10.w),
              ),
              hintText: hintText ?? 'Enter ${title?.toLowerCase() ?? ""}',
              hintStyle: TextStyle(
                fontSize: 13.w,
                color: Colors.grey.withOpacity(.5),
              )),
        ),
      ],
    );
  }
}
