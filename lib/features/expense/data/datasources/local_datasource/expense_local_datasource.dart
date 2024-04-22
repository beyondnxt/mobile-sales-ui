import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';

abstract class ExpenseDataSource {
  Future<List<ExpenseEntity>?> getAllExpense();
}
