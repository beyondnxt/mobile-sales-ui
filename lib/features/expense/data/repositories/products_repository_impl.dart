import 'package:injectable/injectable.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/features/expense/data/datasources/local_datasource/expense_local_datasource.dart';
import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';
import 'package:sales_app/features/expense/domain/repositories/expense_repository.dart';
import 'package:sales_app/features/products/data/datasources/local_datasource/products_local_datasource.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';
import 'package:sales_app/features/products/domain/repositories/product_repository.dart';

@Injectable(as: ExpenseRepository)
class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl({
    required this.localDataSource,
  });

  final ExpenseDataSource localDataSource;

  @override
  Future<ApiResultModel<List<ExpenseEntity?>?>> getAllExpense() async {
    final List<ExpenseEntity>? result = await localDataSource.getAllExpense();
    return ApiResultModel<List<ExpenseEntity>?>.success(
      data: result,
    );
  }
}
