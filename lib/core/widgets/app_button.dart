import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';

class AppButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final double? height;
  final double? width;
  const AppButton(
      {Key? key, this.onTap, required this.title, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
              AppConfigurations appConfigurations) =>
          InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    offset: const Offset(1, 1),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              color: appConfigurations.appTheme.primaryColor,
              borderRadius: const BorderRadius.all(Radius.elliptical(5, 5))),
          child: Text(
            title,
            style: poppinsMedium.copyWith(
              color: appConfigurations.appTheme.backgroundLightColor,
              fontSize: 12.w,
            ),
          ),
        ),
      ),
    );
  }
}
