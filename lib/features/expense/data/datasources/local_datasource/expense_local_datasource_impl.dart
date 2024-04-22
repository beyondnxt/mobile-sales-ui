import 'package:injectable/injectable.dart';
import 'package:sales_app/features/companies/data/datasources/local_datasource/local_database.dart';
import 'package:sales_app/features/expense/data/datasources/local_datasource/expense_local_datasource.dart';
import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';

@Injectable(as: ExpenseDataSource)
class ExpenseDataSourceImpl implements ExpenseDataSource {
  ExpenseDataSourceImpl(this.appLocalDatabase);

  final AppLocalDatabase appLocalDatabase;

  @override
  Future<List<ExpenseEntity>?> getAllExpense() async {
    final List<ExpenseEntity> data = appLocalDatabase.getAllExpense();

    return data;
  }
}
