import 'package:injectable/injectable.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/core/commundomain/usecases/base_params_usecase.dart';
import 'package:sales_app/features/auth/domain/entities/login_entity/login_entity.dart';
import 'package:sales_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';
import 'package:sales_app/features/products/domain/repositories/product_repository.dart';

@injectable
class Auth
    implements BaseParamsUseCase<LoginSuccessEntity?, NoParams> {
  Auth(this.loginRespository);

  final LoginRespository loginRespository;

  @override
  Future<ApiResultModel<LoginSuccessEntity?>> call(NoParams? params) {
    return loginRespository.login();
  }
}
