import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:sales_app/core/basecomponents/base_view_model.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_state.dart';
import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';
import 'package:sales_app/features/expense/domain/usecases/get_all_expense.dart';

@injectable
class ExpenseListViewModel extends BaseViewModel {
  ExpenseListViewModel(
    this.getAllExpense,
  );

  final GetAllExpense getAllExpense;
  final StreamController<ApiResultState<ExpenseEntity?>?> _productResult =
      StreamController<ApiResultState<ExpenseEntity?>?>.broadcast();

  StreamController<ApiResultState<ExpenseEntity?>?> get productResult =>
      _productResult;
  final StreamController<ApiResultState<List<ExpenseEntity?>?>?>
      _productListResult =
      StreamController<ApiResultState<List<ExpenseEntity?>?>?>.broadcast();
  StreamController<ApiResultState<List<ExpenseEntity?>?>?>
      get productListResult => _productListResult;

  Future<void> getAllProductsData() async {
    final ApiResultState<List<ExpenseEntity?>?>? result =
        await executeParamsUseCase(
      useCase: getAllExpense,
    );
    _productListResult.add(result);
  }

  @override
  void onDispose() {
    super.onDispose();
    _productListResult.close();
    _productResult.close();
  }
}
