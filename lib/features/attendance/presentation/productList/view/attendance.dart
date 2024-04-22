import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/basecomponents/base_view_model_view.dart';
import 'package:sales_app/core/utils/auto_router_setup/auto_router.gr.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/core/widgets/app_button.dart';
import 'package:sales_app/core/widgets/profile_avatar.dart';
import 'package:sales_app/features/attendance/presentation/productList/attendance_view_model.dart';

@RoutePage()
class AttendanceView extends StatefulWidget {
  const AttendanceView({
    Key? key,
  }) : super(key: key);

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  AttendanceViewModel? _provider;
  final Map<String, String> _headerRowsData = {
    "CL": "2",
    "LOP": "1",
    "Requested Leave": "1",
    "Requested Leave Status": "Processing",
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      initializeConfig: true,
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
              AppConfigurations appConfigurations) =>
          Scaffold(
        backgroundColor: appConfigurations.appTheme.backgroundLightColor,
        body: SafeArea(
          child: BaseViewModelView<AttendanceViewModel>(
            onInitState: (AttendanceViewModel provider) async {
              _provider = provider;
              await provider.getAllProductsData();
            },
            buildWidget: (AttendanceViewModel provider) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    ProfileAvatarWithName(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      height: 100.h,
                      width: 100.w,
                      name: "John Doe S",
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: _headerRowsData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _leaveRows(appConfigurations,
                              header: _headerRowsData.keys.toList()[index],
                              value: _headerRowsData.values.toList()[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 5.h,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          title: "Request Leave",
                          onTap: () {
                            context.pushRoute(const RequestLeaveView());
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _headerAndValueColumn(appConfigurations,
                                header: 'Date', value: '05-03-2024'),
                            _headerAndValueColumn(appConfigurations,
                                header: 'Punch In ', value: '10.00 AM'),
                            _headerAndValueColumn(appConfigurations,
                                header: 'Punch Out', value: '10.00 PM')
                          ]),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppButton(
                      title: "Punch In ",
                      onTap: () {
                        context.back();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _headerAndValueColumn(AppConfigurations appConfigurations,
      {required String header, required String value}) {
    return Column(
      children: [
        Text(
          header,
          style: poppinsBold.copyWith(
            color: appConfigurations.appTheme.primaryColor,
            fontSize: 14.w,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          value,
          style: poppinsRegular.copyWith(
            color: appConfigurations.appTheme.titleTextColor,
            fontSize: 14.w,
          ),
        ),
      ],
    );
  }

  _leaveRows(AppConfigurations appConfigurations,
      {required String header, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: poppinsBold.copyWith(
            color: appConfigurations.appTheme.titleTextColor,
            fontSize: 14.w,
          ),
        ),
        Text(
          value,
          style: poppinsRegular.copyWith(
            color: appConfigurations.appTheme.titleTextColor,
            fontSize: 14.w,
          ),
        ),
      ],
    );
  }
}
