import 'package:injectable/injectable.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/core/commundomain/usecases/base_params_usecase.dart';
import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';
import 'package:sales_app/features/expense/domain/repositories/expense_repository.dart';

@injectable
class GetAllExpense
    implements BaseParamsUseCase<List<ExpenseEntity?>?, NoParams> {
  GetAllExpense(this.productRepository);

  final ExpenseRepository productRepository;

  @override
  Future<ApiResultModel<List<ExpenseEntity?>?>> call(NoParams? params) {
    return productRepository.getAllExpense();
  }
}
