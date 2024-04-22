import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/core/widgets/app_text_field.dart';

class AddLeadWidget extends StatefulWidget {
  const AddLeadWidget({
    Key? key,
    required this.onTapFunction,
  }) : super(key: key);
  final Function() onTapFunction;

  @override
  State<AddLeadWidget> createState() => _AddLeadWidgetState();
}

class _AddLeadWidgetState extends State<AddLeadWidget> {
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
          AppConfigurations appConfigurations) {
        final space = SizedBox(
          height: 15.h,
        );
        return Dialog(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          backgroundColor: appConfigurations.appTheme.backgroundLightColor,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 20.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Text(
                    "Add Lead",
                    style: poppinsBold.copyWith(
                        color: appConfigurations.appTheme.primaryColor,
                        fontSize: 20.w),
                  ),
                ),
                const Divider(),
                space,
                AppTextField(
                  title: "Company Name",
                  hintText: 'Add Feedback',
                  controller: feedbackController,
                  appConfigurations: appConfigurations,
                ),
                space,
                AppTextField(
                  title: "Street",
                  controller: feedbackController,
                  appConfigurations: appConfigurations,
                ),
                space,
                AppTextField(
                  title: "Village/city",
                  controller: feedbackController,
                  appConfigurations: appConfigurations,
                ),
                space,
                AppTextField(
                  title: "Landmark",
                  controller: feedbackController,
                  appConfigurations: appConfigurations,
                ),
                space,
                AppTextField(
                  title: "Enquiry Date",
                  controller: feedbackController,
                  appConfigurations: appConfigurations,
                ),
                space,
                SizedBox(
                  height: 30.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      widget.onTapFunction();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 6.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.w)),
                        color: appConfigurations.appTheme.primaryColor,
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: appConfigurations.appTheme.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
