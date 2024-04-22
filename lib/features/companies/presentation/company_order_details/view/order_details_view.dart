import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/basecomponents/base_view_model_view.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_state.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/error_result_model.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/core/widgets/product_card.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';
import 'package:sales_app/features/companies/presentation/company_order_details/company_order_details_viewmodel.dart';
import 'package:sales_app/features/companies/presentation/company_order_details/widgets/company_details_widget/add_order/add_new_order_widget.dart';
import 'package:sales_app/features/companies/presentation/company_order_details/widgets/company_details_widget/company_details_widget.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

@RoutePage()
class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({
    Key? key,
    this.orderEntity,
  }) : super(key: key);
  final OrderEntity? orderEntity;

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView>
    with SingleTickerProviderStateMixin {
  OrderEntity? _result;
  final List<ProductEntity?> _addedProductList = [];
  CompanyOrderViewModel? _provider;
  bool? _isSuccess;

  void _listenToInitialFeedBackListData() {
    _provider?.productListResult.stream
        .listen((ApiResultState<List<ProductEntity?>?>? result) {
      result?.when(
        data: (List<ProductEntity?>? data) {
          if (data != null) {
            if (!mounted) {
              return;
            }
            setState(() {
              _addedProductList.addAll(data);
            });
          }
        },
        error: (ErrorResultModel error) {},
      );
    });
  }

  void _listenToProductListData() {
    _provider?.productResult.stream
        .listen((ApiResultState<ProductEntity?>? result) {
      result?.when(
        data: (ProductEntity? data) {
          if (!_addedProductList
              .any((ProductEntity? element) => element?.name == data?.name)) {
            setState(() {
              _addedProductList.add(data);
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
    if (widget.orderEntity != null) {
      _result = widget.orderEntity;
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return BaseViewModelView<CompanyOrderViewModel>(
      onInitState: (CompanyOrderViewModel provider) async {
        _provider = provider;
        _listenToProductListData();
        _listenToInitialFeedBackListData();
        if (_result?.orderNumber != null) {
          await _provider?.getAllProductsData();
        }
      },
      buildWidget: (CompanyOrderViewModel provider) {
        return BaseResponsiveWidget(
          initializeConfig: false,
          buildWidget: (BuildContext context,
              ResponsiveUiConfig responsiveUiConfig,
              AppConfigurations appConfigurations) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: appConfigurations.appTheme.primaryColor,
                  title: Text(
                    _result?.orderNumber != null
                        ? 'Order Details '
                        : 'New Order',
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
                // floatingActionButton: FloatingActionButton(
                //   foregroundColor:
                //       appConfigurations.appTheme.backgroundLightColor,
                //   backgroundColor: appConfigurations.appTheme.primaryColor,
                //   onPressed: () {
                //       showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return AddFeedbackWidget(
                //             onTapFunction: () async {
                //               // if (_controller.text.isNotEmpty && !_checkItemInList()) {
                //               //   await _provider?.getWeatherByCity(
                //               //       cityName: _controller.text);
                //               // }
                //             },
                //           );
                //         },
                //       );

                //   },
                //   child: const Icon(
                //     Icons.add,
                //   ),
                // ),
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
                                  return OrderDetailsViewHeader(
                                    orderEntity: _result,
                                  );
                                }
                              case 1:
                                {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Products',
                                              style: poppinsBold.copyWith(
                                                color: appConfigurations
                                                    .appTheme.primaryColor,
                                                fontSize: 18.w,
                                              ),
                                            ),
                                            if (_addedProductList.isNotEmpty)
                                              const AddProductWidget(),
                                          ],
                                        ),
                                        SizedBox(height: 15.w),
                                        if (_addedProductList.isNotEmpty)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Count - 2',
                                                style: poppinsBold.copyWith(
                                                  color: appConfigurations
                                                      .appTheme.titleTextColor,
                                                  fontSize: 12.w,
                                                ),
                                              ),
                                              Text(
                                                'Total Price : 10,000 RS',
                                                style: poppinsBold.copyWith(
                                                  color: appConfigurations
                                                      .appTheme.titleTextColor,
                                                  fontSize: 12.w,
                                                ),
                                              ),
                                            ],
                                          ),
                                        SizedBox(height: 4.w),
                                      ],
                                    ),
                                  );
                                }
                              case 2:
                                {
                                  if (_addedProductList.isEmpty) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 100.w,
                                        ),
                                        Text("No Product Found",
                                            style: poppinsBold.copyWith(
                                              color: appConfigurations
                                                  .appTheme.titleTextColor,
                                              fontSize: 16.w,
                                            )),
                                        SizedBox(
                                          height: 20.w,
                                        ),
                                        const AddProductWidget()
                                      ],
                                    );
                                  }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _addedProductList.length,
                                      itemBuilder: (context, index) =>
                                          ProductCard(
                                            fromOrder: true,
                                            productEntity:
                                                _addedProductList[index],
                                          ));
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
