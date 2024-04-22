import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';

abstract class ExpenseRepository {
  Future<ApiResultModel<List<ExpenseEntity?>?>> getAllExpense();
}
