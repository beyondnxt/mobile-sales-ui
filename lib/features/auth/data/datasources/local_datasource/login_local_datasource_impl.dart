import 'package:injectable/injectable.dart';
import 'package:sales_app/features/auth/data/datasources/local_datasource/login_local_datasource.dart';
import 'package:sales_app/features/auth/domain/entities/login_entity/login_entity.dart';
import 'package:sales_app/features/companies/data/datasources/local_datasource/local_database.dart';

@Injectable(as: AuthDataSource)
class LoginDataSourceImpl implements AuthDataSource {
  LoginDataSourceImpl(this.appLocalDatabase);

  final AppLocalDatabase appLocalDatabase;

  @override
  Future<LoginSuccessEntity?> login() async {
    final LoginSuccessEntity? data = await appLocalDatabase.login();

    return data;
  }
}
