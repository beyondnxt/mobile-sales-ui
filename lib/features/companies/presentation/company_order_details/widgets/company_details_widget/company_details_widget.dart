import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';

class OrderDetailsViewHeader extends StatelessWidget {
  const OrderDetailsViewHeader({
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
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            margin: EdgeInsets.all(15.w),
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
                        "#${orderEntity?.orderNumber ?? "00000"}",
                        style: poppinsBold.copyWith(
                          color:
                              appConfigurations.appTheme.backgroundLightColor,
                          fontSize: 14.w,
                        ),
                      ),
                      Text(
                        orderEntity?.createdBy?.toString() ?? 'Kumar S',
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
                        orderEntity?.orderCreatedDate?.toString() ??
                            DateTime.now().toString().substring(0, 10),
                        style: poppinsRegular.copyWith(
                          fontSize: 13.w,
                          color:
                              appConfigurations.appTheme.backgroundLightColor,
                        ),
                      ),
                      Text(
                        orderEntity?.statusOfProcessing?.toString() ??
                            'New Order',
                        style: poppinsRegular.copyWith(
                          fontSize: 12.w,
                          color:
                              appConfigurations.appTheme.backgroundLightColor,
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
