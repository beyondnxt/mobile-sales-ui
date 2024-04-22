import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/basecomponents/base_view_model_view.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_state.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/error_result_model.dart';
import 'package:sales_app/core/utils/auto_router_setup/auto_router.gr.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/feedback_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';
import 'package:sales_app/features/companies/presentation/company/company_details_viewmodel.dart';
import 'package:sales_app/features/companies/presentation/company/widgets/company_details_widget/add_feedback/add_feedback_widget.dart';
import 'package:sales_app/features/companies/presentation/company/widgets/company_details_widget/company_details_widget.dart';
import 'package:sales_app/features/companies/presentation/company/widgets/company_details_widget/tabs_view/feedback_tab.dart';
import 'package:sales_app/features/companies/presentation/company/widgets/company_details_widget/tabs_view/order_tab.dart';

@RoutePage()
class CompanyDetailsView extends StatefulWidget {
  const CompanyDetailsView({
    Key? key,
    this.companyInfoEntity,
  }) : super(key: key);
  final CompanyInfoEntity? companyInfoEntity;

  @override
  State<CompanyDetailsView> createState() => _CompanyDetailsViewState();
}

class _CompanyDetailsViewState extends State<CompanyDetailsView>
    with SingleTickerProviderStateMixin {
  CompanyInfoEntity? _result;
  final List<OrderEntity?> _orderList = [];
  final List<FeedbackEntity?> _feedbackList = [];
  bool? _isSuccess;
  late TabController _tabController;
  CompanyDetailsViewModel? _provider;

  void _listenToInitialFeedBackListData() {
    _provider?.feedbackListResult.stream
        .listen((ApiResultState<List<FeedbackEntity?>?>? result) {
      result?.when(
        data: (List<FeedbackEntity?>? data) {
          if (data != null) {
            if (!mounted) {
              return;
            }
            setState(() {
              _feedbackList.addAll(data);
            });
          }
        },
        error: (ErrorResultModel error) {},
      );
    });
  }

  void _listenToFeedListData() {
    _provider?.feedbackResult.stream
        .listen((ApiResultState<FeedbackEntity?>? result) {
      result?.when(
        data: (FeedbackEntity? data) {
          if (!_feedbackList.any((FeedbackEntity? element) =>
              element?.feedBackDescription == data?.feedBackDescription)) {
            setState(() {
              _feedbackList.add(data);
            });
          }
        },
        error: (ErrorResultModel error) {},
      );
    });
  }

  void _listenToOrderListData() {
    _provider?.orderResult.stream
        .listen((ApiResultState<OrderEntity?>? result) {
      result?.when(
        data: (OrderEntity? data) {
          if (!_orderList.any((OrderEntity? element) =>
              element?.orderNumber == data?.orderNumber)) {
            setState(() {
              _orderList.add(data);
            });
          }
        },
        error: (ErrorResultModel error) {},
      );
    });
  }

  void _listenToInitialLocalData() {
    _provider?.orderListResult.stream
        .listen((ApiResultState<List<OrderEntity?>?>? result) {
      result?.when(
        data: (List<OrderEntity?>? data) {
          if (data != null) {
            if (!mounted) {
              return;
            }
            setState(() {
              _orderList.addAll(data);
            });
          }
        },
        error: (ErrorResultModel error) {},
      );
    });
  }

  Widget _getWidget(ResponsiveUiConfig responsiveUiConfig) {
    if (_isSuccess == false) {
      return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: responsiveUiConfig.screenHeight,
            child: Center(
              child: Lottie.asset(
                'assets/lottie_animation.json',
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.companyInfoEntity != null) {
      _result = widget.companyInfoEntity;
    }
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext buildContext) {
    return BaseViewModelView<CompanyDetailsViewModel>(
      onInitState: (CompanyDetailsViewModel provider) async {
        _provider = provider;
        _listenToInitialLocalData();
        _listenToOrderListData();
        _listenToFeedListData();
        _listenToInitialFeedBackListData();
        await provider.getAllOrdersData();
        await provider.getAllFeedbackData();
      },
      buildWidget: (CompanyDetailsViewModel provider) {
        return BaseResponsiveWidget(
          initializeConfig: true,
          buildWidget: (BuildContext context,
              ResponsiveUiConfig responsiveUiConfig,
              AppConfigurations appConfigurations) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: appConfigurations.appTheme.primaryColor,
                  title: Text(
                    'Company ',
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
                backgroundColor: Colors.white,
                floatingActionButton: FloatingActionButton(
                  foregroundColor:
                      appConfigurations.appTheme.backgroundLightColor,
                  backgroundColor: appConfigurations.appTheme.primaryColor,
                  onPressed: () {
                    if (_tabController.index == 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddFeedbackWidget(
                            onTapFunction: () async {
                              // if (_controller.text.isNotEmpty && !_checkItemInList()) {
                              //   await _provider?.getWeatherByCity(
                              //       cityName: _controller.text);
                              // }
                            },
                          );
                        },
                      );
                    } else {
                      context.pushRoute(
                          OrderDetailsView(orderEntity: const OrderEntity()));
                    }
                  },
                  child: const Icon(
                    Icons.add,
                  ),
                ),
                body: SafeArea(
                    child: RefreshIndicator(
                  backgroundColor:
                      appConfigurations.appTheme.backgroundLightColor,
                  color: appConfigurations.appTheme.primaryColor,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  strokeWidth: 2.w,
                  onRefresh: () async {},
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      if (_result != null)
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            switch (index) {
                              case 0:
                                {
                                  return CompanyDetailsViewHeader(
                                    companyInfoEntity: _result,
                                  );
                                }
                              case 1:
                                {
                                  return TabBar(
                                    indicatorColor:
                                        appConfigurations.appTheme.primaryColor,
                                    labelStyle: TextStyle(
                                        color: appConfigurations
                                            .appTheme.primaryColor),
                                    controller: _tabController,
                                    tabs: const [
                                      Tab(text: 'Order'),
                                      Tab(text: 'Feedback'),
                                    ],
                                  );
                                }
                              case 2:
                                {
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.w),
                                    height: 700.w,
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: _orderList.length,
                                            itemBuilder: (context, index) =>
                                                OrderTabCard(
                                                  onClickBox: (OrderEntity?
                                                      companyInfoEntity) {
                                                    context.pushRoute(
                                                      OrderDetailsView(
                                                          orderEntity:
                                                              companyInfoEntity),
                                                    );
                                                  },
                                                  orderEntity:
                                                      _orderList[index],
                                                )),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: _feedbackList.length,
                                            padding: const EdgeInsets.only(
                                                bottom: 100),
                                            itemBuilder: (context, index) =>
                                                FeedbackTabCard(
                                                  feedbackEntity:
                                                      _feedbackList[index],
                                                )),
                                      ],
                                    ),
                                  );
                                }

                              default:
                                {
                                  return SizedBox(
                                    height: 90.h,
                                  );
                                }
                            }
                          },
                        )
                      else
                        _getWidget(responsiveUiConfig),
                    ],
                  ),
                )));
          },
        );
      },
    );
  }
}
