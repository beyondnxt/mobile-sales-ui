import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/features/auth/domain/entities/login_entity/login_entity.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

abstract class LoginRespository {
  Future<ApiResultModel<LoginSuccessEntity?>> login();
}
