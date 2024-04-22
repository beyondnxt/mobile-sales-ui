import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/basecomponents/base_view_model_view.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_state.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/error_result_model.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/features/companies/presentation/companyList/widgets/serach_company/search_company_widget.dart';
import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';
import 'package:sales_app/features/expense/presentation/expense_list/expense_list_viewmodel.dart';
import 'package:sales_app/features/expense/presentation/expense_list/widgets/add_expense/add_expense.dart';
import 'package:sales_app/features/expense/presentation/expense_list/widgets/expense_widget/expense_card.dart';

@RoutePage()
class ExpenseListView extends StatefulWidget {
  const ExpenseListView({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpenseListView> createState() => _ExpenseListViewState();
}

class _ExpenseListViewState extends State<ExpenseListView> {
  final TextEditingController _searchController = TextEditingController();
  ExpenseListViewModel? _provider;
  final List<ExpenseEntity?> _allExpense = [];

  void _listenToInitialFeedBackListData() {
    _provider?.productListResult.stream
        .listen((ApiResultState<List<ExpenseEntity?>?>? result) {
      result?.when(
        data: (List<ExpenseEntity?>? data) {
          if (data != null) {
            if (!mounted) {
              return;
            }
            setState(() {
              _allExpense.addAll(data);
            });
          }
        },
        error: (ErrorResultModel error) {},
      );
    });
  }

  void _listenToProductListData() {
    _provider?.productResult.stream
        .listen((ApiResultState<ExpenseEntity?>? result) {
      result?.when(
        data: (ExpenseEntity? data) {
          if (!_allExpense
              .any((ExpenseEntity? element) => element?.date == data?.date)) {
            setState(() {
              _allExpense.add(data);
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
        floatingActionButton: FloatingActionButton(
          foregroundColor: appConfigurations.appTheme.backgroundLightColor,
          backgroundColor: appConfigurations.appTheme.primaryColor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddExpenseWidget(
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
          child: BaseViewModelView<ExpenseListViewModel>(
            onInitState: (ExpenseListViewModel provider) async {
              _provider = provider;
              _listenToInitialFeedBackListData();
              _listenToProductListData();
              await provider.getAllProductsData();
            },
            buildWidget: (ExpenseListViewModel provider) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SearchCompanyWidget(
                      controller: _searchController, onTapFunction: () {}),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _allExpense.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _allExpense.isNotEmpty
                              ? ExpenseCard(
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
}
