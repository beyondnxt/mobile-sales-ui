import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/basecomponents/base_view_model_view.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/features/attendance/domain/entities/leave_response_entity/leave_entity.dart';
import 'package:sales_app/features/attendance/presentation/productList/widgets/add_request/add_expense.dart';
import 'package:sales_app/features/attendance/presentation/productList/widgets/request_card.dart';
import 'package:sales_app/features/products/presentation/productList/product_list_viewmodel.dart';

@RoutePage()
class RequestLeaveView extends StatefulWidget {
  const RequestLeaveView({
    Key? key,
  }) : super(key: key);

  @override
  State<RequestLeaveView> createState() => _RequestLeaveViewState();
}

class _RequestLeaveViewState extends State<RequestLeaveView> {
  ProductListViewModel? _provider;
  final List _allExpense = [
    const LeaveEntity(date: "11-04-2024", type: "Casual Leave"),
    const LeaveEntity(date: "30-04-2024", type: "Casual Leave"),
    const LeaveEntity(date: "23-06-2024", type: "Casual Leave")
  ];

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
        appBar: AppBar(
          backgroundColor: appConfigurations.appTheme.primaryColor,
          title: Text(
            'Request Leave',
            style: TextStyle(
                color: appConfigurations.appTheme.backgroundLightColor),
          ),
          leading: InkWell(
            onTap: () {
              context.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: appConfigurations.appTheme.backgroundLightColor,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: appConfigurations.appTheme.backgroundLightColor,
          backgroundColor: appConfigurations.appTheme.primaryColor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddRequestLeave(
                  onTapFunction: () async {
                    // if (_controller.text.isNotEmpty && !_checkItemInList()) {
                    //   await _provider?.getWeatherByCity(
                    //       cityName: _controller.text);
                    // }
                  },
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          child: BaseViewModelView<ProductListViewModel>(
            onInitState: (ProductListViewModel provider) async {
              _provider = provider;
              await provider.getAllProductsData();
            },
            buildWidget: (ProductListViewModel provider) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        shrinkWrap: true,
                        itemCount: _allExpense.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _allExpense.isNotEmpty
                              ? RequestCard(
                                  expenseEntity: _allExpense[index],
                                )
                              : Container();
                        }),
                  ),
                ],
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
            color: appConfigurations.appTheme.titleTextColor,
            fontSize: 12.w,
          ),
        ),
        Text(
          value,
          style: poppinsBold.copyWith(
            color: appConfigurations.appTheme.titleTextColor,
            fontSize: 12.w,
          ),
        ),
      ],
    );
  }

  _leaveRows(AppConfigurations appConfigurations,
      {required String header, required String value}) {
    return Column(
      children: [
        Text(
          header,
          style: poppinsBold.copyWith(
            color: appConfigurations.appTheme.titleTextColor,
            fontSize: 12.w,
          ),
        ),
        Text(
          value,
          style: poppinsBold.copyWith(
            color: appConfigurations.appTheme.titleTextColor,
            fontSize: 12.w,
          ),
        ),
      ],
    );
  }
}
