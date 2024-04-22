import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/basecomponents/base_view_model_view.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_state.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/error_result_model.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/core/widgets/app_button.dart';
import 'package:sales_app/core/widgets/product_card.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';
import 'package:sales_app/features/products/presentation/productList/product_list_viewmodel.dart';
import 'package:sales_app/features/products/presentation/productList/widgets/search_product/search_product_widget.dart';

@RoutePage()
class ProductListView extends StatefulWidget {
  final bool fromOrder;
  const ProductListView({Key? key, this.fromOrder = false}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController modelController = TextEditingController();

  final TextEditingController sizeController = TextEditingController();

  final TextEditingController skuController = TextEditingController();
  ProductListViewModel? _provider;
  final List<ProductEntity?> _allProductList = [];

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
              _allProductList.addAll(data);
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
          if (!_allProductList
              .any((ProductEntity? element) => element?.name == data?.name)) {
            setState(() {
              _allProductList.add(data);
            });
          }
        },
        error: (ErrorResultModel error) {},
      );
    });
  }

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
        appBar: widget.fromOrder
            ? AppBar(
                backgroundColor: appConfigurations.appTheme.primaryColor,
                title: Text(
                  'Products',
                  style: TextStyle(
                      color: appConfigurations.appTheme.backgroundLightColor),
                ),
                leading: InkWell(
                  onTap: () {
                    context.back();
                  },
                  child: Icon(
                    widget.fromOrder ? Icons.arrow_back_ios : Icons.menu,
                    color: appConfigurations.appTheme.backgroundLightColor,
                  ),
                ),
              )
            : null,
        body: SafeArea(
          child: BaseViewModelView<ProductListViewModel>(
            onInitState: (ProductListViewModel provider) async {
              _provider = provider;
              _listenToInitialFeedBackListData();
              _listenToProductListData();
              await provider.getAllProductsData();
            },
            buildWidget: (ProductListViewModel provider) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SearchProductWidget(
                      nameController: nameController,
                      skuController: skuController,
                      modelController: modelController,
                      sizeController: sizeController,
                      onTapFunction: () {}),
                  if (widget.fromOrder)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Count - 2',
                              style: poppinsBold.copyWith(
                                color:
                                    appConfigurations.appTheme.titleTextColor,
                                fontSize: 12.w,
                              ),
                            ),
                            Text(
                              'Total Price : 10,000 RS',
                              style: poppinsBold.copyWith(
                                color:
                                    appConfigurations.appTheme.titleTextColor,
                                fontSize: 12.w,
                              ),
                            ),
                          ]),
                    ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _allProductList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _allProductList.isNotEmpty
                              ? ProductCard(
                                  fromOrder: widget.fromOrder,
                                  productEntity: _allProductList[index],
                                  isAdded: index % 2 == 0,
                                )
                              : Container();
                        }),
                  ),
                  if (widget.fromOrder)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              height: 30.w,
                              title: "Submit ",
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
