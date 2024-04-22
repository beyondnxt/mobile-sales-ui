import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/feedback_entity.dart';

class FeedbackTabCard extends StatelessWidget {
  const FeedbackTabCard({
    Key? key,
    this.feedbackEntity,
    this.onClickBox,
  }) : super(key: key);
  final FeedbackEntity? feedbackEntity;
  final Function(FeedbackEntity? weatherInfoEntity)? onClickBox;

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
          AppConfigurations appConfigurations) {
        return GestureDetector(
          onTap: () {
            if (onClickBox != null) {
              onClickBox!(feedbackEntity);
            }
          },
          child: Container(
            width: responsiveUiConfig.screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: appConfigurations.appTheme.backgroundLightColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.w,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        feedbackEntity?.createdBy ?? '',
                        style: poppinsBold.copyWith(
                          fontSize: 12.w,
                          fontWeight: FontWeight.w600,
                          color: appConfigurations.appTheme.primaryColor,
                        ),
                      ),
                      Text(
                        feedbackEntity?.orderCreatedDate ?? '',
                        style: poppinsRegular.copyWith(
                          fontSize: 12.w,
                          color: appConfigurations.appTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          feedbackEntity?.feedBackDescription?.toString() ?? '',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.w,
                            color: appConfigurations.appTheme.subTitleTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
