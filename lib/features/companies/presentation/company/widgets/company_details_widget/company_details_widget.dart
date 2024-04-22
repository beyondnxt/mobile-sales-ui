import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';

class CompanyDetailsViewHeader extends StatelessWidget {
  const CompanyDetailsViewHeader({
    Key? key,
    this.companyInfoEntity,
    this.onClickBox,
  }) : super(key: key);
  final CompanyInfoEntity? companyInfoEntity;
  final Function(CompanyInfoEntity? weatherInfoEntity)? onClickBox;

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
          AppConfigurations appConfigurations) {
        return GestureDetector(
          onTap: () {
            if (onClickBox != null) {
              onClickBox!(companyInfoEntity);
            }
          },
          child: Container(
            width: responsiveUiConfig.screenWidth,
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            margin: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
                colors: <Color>[
                  appConfigurations.appTheme.primaryColor,
                  Colors.blue,
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.w,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyInfoEntity?.name ?? '',
                        style: poppinsBold.copyWith(
                          color:
                              appConfigurations.appTheme.backgroundLightColor,
                          fontSize: 18.w,
                        ),
                      ),
                      Text(
                        companyInfoEntity?.address?.toString() ?? '',
                        style: poppinsRegular.copyWith(
                          fontSize: 12.w,
                          color:
                              appConfigurations.appTheme.backgroundLightColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "+91 ${companyInfoEntity?.phoneNumber?.toString() ?? ''}",
                        style: poppinsRegular.copyWith(
                          fontSize: 13.w,
                          color:
                              appConfigurations.appTheme.backgroundLightColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        width: 50.w,
                        height: 40.w,
                        child: const Icon(
                          Icons.call,
                          size: 30,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
