import 'package:sales_app/core/utils/mapper/data_mapper.dart';
import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';

class ExpenseDataMapperToEntity extends DataMapper<ExpenseEntity> {
  ExpenseDataMapperToEntity({
    this.expense,
    this.date,
  });

  String? expense;
  String? date;

  @override
  ExpenseEntity mapToEntity() {
    return ExpenseEntity(
      expense: expense,
      date: date,
    );
  }
}
