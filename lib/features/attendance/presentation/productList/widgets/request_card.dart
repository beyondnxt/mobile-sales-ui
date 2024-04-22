import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/features/attendance/domain/entities/leave_response_entity/leave_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';
import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    Key? key,
    this.expenseEntity,
    this.onClickBox,
  }) : super(key: key);
  final LeaveEntity? expenseEntity;
  final Function(CompanyInfoEntity? weatherInfoEntity)? onClickBox;

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
          AppConfigurations appConfigurations) {
        return GestureDetector(
          onTap: () {
          },
          child: Container(
            width: responsiveUiConfig.screenWidth,
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 5.h,
            ),
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: appConfigurations.appTheme.backgroundLightColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 1, // Blur radius
                  offset: const Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.w,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        expenseEntity?.type?? '',
                        style: poppinsRegular.copyWith(
                          fontSize: 16.w,
                          color: appConfigurations.appTheme.primaryColor,
                        ),
                      ),
                    
                    ],
                  ),
                ),
                SizedBox(
                    height: 55.w,
                    width: 20.w,
                    child: VerticalDivider(
                      width: 2,
                      color: appConfigurations.appTheme.secondaryColor,
                    )),
                Center(
                  child: Icon(
                    Icons.call,
                    size: 30,
                    color: appConfigurations.appTheme.primaryColor,
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
