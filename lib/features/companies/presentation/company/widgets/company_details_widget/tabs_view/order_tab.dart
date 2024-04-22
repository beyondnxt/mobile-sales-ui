import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';

class OrderTabCard extends StatelessWidget {
  const OrderTabCard({
    Key? key,
    this.orderEntity,
    this.onClickBox,
  }) : super(key: key);
  final OrderEntity? orderEntity;
  final Function(OrderEntity? weatherInfoEntity)? onClickBox;

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
          AppConfigurations appConfigurations) {
        return GestureDetector(
          onTap: () {
            if (onClickBox != null) {
              onClickBox!(orderEntity);
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 2.h,
                      ),
                      child: Text(
                        orderEntity?.createdBy ?? '',
                        style: poppinsRegular.copyWith(
                          fontSize: 16.w,
                          color: appConfigurations.appTheme.primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 90.w,
                      padding: EdgeInsets.symmetric(vertical: 3.w),
                      decoration: BoxDecoration(
                          color: appConfigurations.appTheme.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.w),
                              bottomLeft: Radius.circular(10.w))),
                      child: Text(orderEntity?.statusOfProcessing ?? "",
                          style: poppinsRegular.copyWith(
                            fontSize: 11.w,
                            color:
                                appConfigurations.appTheme.backgroundLightColor,
                          )),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#${orderEntity?.orderNumber?.toString() ?? ''}",
                        style: poppinsRegular.copyWith(
                          fontSize: 13.w,
                          color: appConfigurations.appTheme.primaryColor,
                        ),
                      ),
                      Text(
                        orderEntity?.orderCreatedDate ?? '',
                        style: poppinsRegular.copyWith(
                          fontSize: 12.w,
                          color: appConfigurations.appTheme.primaryColor,
                        ),
                      ),
                    ],
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
