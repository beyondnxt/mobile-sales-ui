import 'package:injectable/injectable.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/features/auth/data/datasources/local_datasource/login_local_datasource.dart';
import 'package:sales_app/features/auth/domain/entities/login_entity/login_entity.dart';
import 'package:sales_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:sales_app/features/products/data/datasources/local_datasource/products_local_datasource.dart';

@Injectable(as: LoginRespository)
class LoginRepositoryImpl implements LoginRespository {
  LoginRepositoryImpl({
    required this.localDataSource,
  });

  final AuthDataSource localDataSource;

  @override
  Future<ApiResultModel<LoginSuccessEntity?>> login() async {
    final LoginSuccessEntity? result = await localDataSource.login();
    return ApiResultModel<LoginSuccessEntity?>.success(
      data: result,
    );
  }
}
