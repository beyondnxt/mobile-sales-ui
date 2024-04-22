import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/widgets/app_text_field.dart';

class SearchCompanyWidget extends StatelessWidget {
  const SearchCompanyWidget({
    Key? key,
    this.controller,
    required this.onTapFunction,
  }) : super(key: key);
  final TextEditingController? controller;
  final Function() onTapFunction;

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
          AppConfigurations appConfigurations) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
              child: AppTextField(
                hintText: 'Search ',
                controller: controller,
                appConfigurations: appConfigurations,
              ),
            ),
          ],
        );
      },
    );
  }
}
