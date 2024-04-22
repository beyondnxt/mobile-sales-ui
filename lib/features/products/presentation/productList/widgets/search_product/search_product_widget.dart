import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/core/widgets/app_text_field.dart';

class SearchProductWidget extends StatelessWidget {
  const SearchProductWidget({
    Key? key,
    required this.onTapFunction,
    required this.nameController,
    required this.modelController,
    required this.sizeController,
    required this.skuController,
  }) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController modelController;

  final TextEditingController sizeController;

  final TextEditingController skuController;
  final Function() onTapFunction;

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
          AppConfigurations appConfigurations) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      title: "Name",
                      hintText: 'Enter Name',
                      controller: nameController,
                      appConfigurations: appConfigurations,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: AppTextField(
                      title: "Model",
                      hintText: 'Enter Model',
                      controller: modelController,
                      appConfigurations: appConfigurations,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      title: "Size",
                      hintText: 'Enter Size',
                      controller: sizeController,
                      appConfigurations: appConfigurations,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: AppTextField(
                      title: "SKU",
                      hintText: 'Enter SKU',
                      controller: skuController,
                      appConfigurations: appConfigurations,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [SearchWidget()],
              )
            ],
          ),
        );
      },
    );
  }
}

class SearchWidget extends StatelessWidget {
  final void Function()? onTap;
  const SearchWidget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
              AppConfigurations appConfigurations) =>
          Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
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
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(5, 5))),
              child: Text(
                'Search',
                style: poppinsMedium.copyWith(
                  color: appConfigurations.appTheme.backgroundLightColor,
                  fontSize: 12.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
